//@dart=2.9
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference InfoUser =
      FirebaseFirestore.instance.collection('InfoUsers');

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    _preference.setString("auth", "not_authenticated");
    await _firebaseAuth.signOut();
  }

  Future<String> sendNotification({String title, String body}) async {
    InfoUser.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        await http.post(Uri.parse('https://api.rnfirebase.io/messaging/send'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'token': doc["token"],
              'data': {
                'title': title,
                'body': body,
              },
            }));
      });
    });
    return "Signed in";
  }

  Future<String> SignIn({String email, String password}) async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    _preference.setString("auth", "authenticated");
    _preference.setString("email", '$email');
    _preference.setString("pass", "$password");
    return "Signed in";
  }

  Future<String> signUp(
      {String email,
      String password,
      String firstName,
      String lastName}) async {
    var err;
    // try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String token = await FirebaseMessaging.instance.getToken();
      InfoUser.doc(result.user.uid).set({
        'first name': firstName,
        'last name': lastName,
        'email': email,
        "token": token
      });

      SharedPreferences _preference = await SharedPreferences.getInstance();
      _preference.setString("auth", "authenticated");
    // } catch (e) {}
    return "hey";
  }
}

class Validator {
  static String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email can't be null";
    }

    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return "Password can't be null";
    }
    if (value.length < 6) {
      return "password length can't be lower than 6 carecteres";
    }

    return null;
  }

  static String validateFirstName(String value) {
    if (value.isEmpty) {
      return "First Name can't be null";
    }

    return null;
  }

  static String validateLastName(String value) {
    if (value.isEmpty) {
      return "Last Name can't be null";
    }

    return null;
  }
}
