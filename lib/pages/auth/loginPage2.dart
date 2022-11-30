import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/HomePage.dart';
import 'package:flutter_application/event_screen.dart';
import 'package:flutter_application/helper/helper_function.dart';
import 'package:flutter_application/interest_screen_1.dart';
import 'package:flutter_application/pages/auth/registerpage2.dart';
import 'package:flutter_application/services/auth_services.dart';
import 'package:flutter_application/services/firestore_services.dart';
import 'package:flutter_application/widgets/widgets.dart';

class loginPage2 extends StatefulWidget {
  static String tag = 'login-Page-2';

  @override
  State<loginPage2> createState() => _loginPage2State();
}

class _loginPage2State extends State<loginPage2> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : Center(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          'Get Started!',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 7.5,
                        ),
                        TextFormField(
                          decoration: textinputDecoration.copyWith(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9)),
                              hintText: 'Email',
                              fillColor: Color(0xFF838383),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              )),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter an email';
                            } else if (!value.contains('@')) {
                              return 'Please Enter An email in correct format';
                              // } else if (!value.contains('fiu.edu')) {
                              //   return 'Please use your FIU email adress';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textinputDecoration.copyWith(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              hintText: 'Password',
                              fillColor: Color(0xFF838383),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              )),
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter a Password';
                            } else if (value.length < 8) {
                              return 'Password Must Have at least 8 characters';
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: () {},
                        ),
                        TextButton(
                          child: Text(
                            'Create An Account',
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(RegisterPage2.tag);
                          },
                        ),
                        SizedBox(
                          height: 150,
                        ),

                        Row(
                          //row 9 - "next" button
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //The actual formatting of the 'Next' button and everything we do for it
                            SizedBox(
                              width: 250.0,
                              height: 55.0,
                              child: ElevatedButton(
                                  onPressed: () {
                                    login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff4589FF),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  login() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWemailAndPasswword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot = await FirestoreServices(
                  uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(email);

          //saving values to our shared preferences
          await HelperFunctions.saveUserEmail(email);
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserNameInStatus(
              snapshot.docs[0]['username']);
          nextScreenReplace(context, EventScreen());
        } else {
          showsnackbar(context, Colors.black, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
