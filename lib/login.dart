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

class LoginPage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  LoginPage1 createState() => LoginPage1();
}

class LoginPage1 extends State<LoginPage> {
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                          key: formKey,
                          child: Column(children: <Widget>[
                            makeInput2(label: "email"),
                            makeInput(label: "Password", obscureText: true),
                          ])),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 2, left: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[700]),
                                top: BorderSide(color: Colors.grey[700]),
                                left: BorderSide(color: Colors.grey[700]),
                                right: BorderSide(color: Colors.grey[700]),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              try {
                                
                                final isValid = formKey.currentState.validate();
                                if (isValid) {
                                  formKey.currentState.save();
                                  context.read<AuthenticationService>().SignIn(
                                      email: emailctrl.text.trim(),
                                      password: passctrl.text.trim()).onError((error, stackTrace) {
                                         ScaffoldMessenger.of(context)
                                  ..removeCurrentMaterialBanner()
                                  ..showMaterialBanner(MaterialBanner(
                                    content:  Text(
                                       error.message),
                                    leading: const Icon(Icons.info),
                                    backgroundColor: Colors.yellow,
                                    actions: [
                               
                                      IconButton(
                                        icon:Icon( Icons.close),
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentMaterialBanner();
                                          },
                                         
                                       ) ],
                                  ));
                                  return"riht";

                                      });
                                }
                              } catch (e) {
                               
                              }
                            },
                            color: Colors.red.withOpacity(0.9),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: processing == false
                                ? Text(
                                    "login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  )
                                : CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                  ),
                          ),
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Dont't have an account?"),
                          TextButton(
                            child: Text("Signup",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Auth1()));
                            },
                          )
                        ])
                  ],
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height / 3.11,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: AssetImage('assets/rezgui.jpg'),
                //           fit: BoxFit.cover)),
                // )
              ]),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              )),
          SizedBox(
            height: 5,
          ),
          TextFormField(
              validator: Validator.validatePassword,
              obscureText: obscureText,
              controller: passctrl,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
              )),
          SizedBox(
            height: 30,
          )
        ]);
  }

  Widget makeInput2({label, obscureText = false}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              )),
          SizedBox(
            height: 5,
          ),
          TextFormField(
              validator: Validator.validateEmail,
              obscureText: obscureText,
              controller: emailctrl,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400])),
              )),
          SizedBox(
            height: 30,
          )
        ]);
  }
}
