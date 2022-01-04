//@dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:following_news/Signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'api/notificationApi.dart';
import 'app.dart';
import 'package:http/http.dart' show Client;


import 'authentication/authentication_service.dart';
import 'login.dart';

String graphApi = "https://graph.facebook.com/v11.0/me?fields=posts.limit(20){picture,attachments{media_type,url,media,type,subattachments},message,created_time,permalink_url}&access_token=EAAhw2JKk20sBAM8ZBNgIXWbZBb7QS3u2d3YGQalMnrNTl1fR7d9RyjqF6KzcXnHrhNkRkekfWfIdNgZBiqjn1ZBucZAB9rDjAVAZCrnWVtukr7HG18n79o6XVvXeQDZAXdhsEr1hAWXavAIxsr4V4YqYZChkJ38FnF1qPGBr7KAoeeGLWDBDmoOa";


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.data);
  print(message.notification);

  // NotificationService().showNotification(
  //   message.data.hashCode, message.data['title'],message.data['body'], 10);
}


class Auth extends StatelessWidget {
  const Auth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges)
      ],
      child: MaterialApp(
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class Auth1 extends StatelessWidget {
  const Auth1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        home: AuthenticationWrapper1(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({ Key key }) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  

 

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
 
    if (firebaseUser != null  ) {
      return MyApp();
    }
    return LoginPage();
  }
}



class AuthenticationWrapper1 extends StatelessWidget {
  const AuthenticationWrapper1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return MyApp();
    }
    return SignupPage();
  }
}

getToken() async {
  String token = await FirebaseMessaging.instance.getToken();

  print(token);
  return token;
}
