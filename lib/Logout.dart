//@dart=2.9
import 'package:flutter/material.dart';
import 'package:following_news/Signup.dart';
import 'package:following_news/authentication/authentication_service.dart';
import 'package:following_news/main.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  // This widget is the root of your application.
  @override
  Logout1 createState() => Logout1();
}

class Logout1 extends State<Logout> {
  bool processing = false;
  TextEditingController firstnamectrl, lastnamectrl, emailctrl, passctrl;
  String _error;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstnamectrl = new TextEditingController();
    lastnamectrl = new TextEditingController();
    passctrl = new TextEditingController();
    emailctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Center(
            child: FloatingActionButton(
              child: Text("Logout"),onPressed: () {
              context.read<AuthenticationService>().signOut();
            }),
          ),
        ),
      ),
    );
  }
}
