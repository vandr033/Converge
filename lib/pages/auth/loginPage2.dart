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
                          height: 35,
                        ),
                        Container(
                            height: 200,
                            decoration: BoxDecoration(
                              //color: Colors.blue,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/Converge.png"),
                                //fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          height: 35,
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3F3F3F)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Email',
                                fillColor: Color(0xff838383),
                                filled: true,
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
                                return 'Please Enter A Valid Email';
                              } else if (!value.contains('@')) {
                                return 'Please Enter An Email In The Correct Format';
                                // } else if (!value.contains('fiu.edu')) {
                                //   return 'Please use your FIU email adress';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: 'Password',
                                fillColor: Color(0xff838383),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter A Valid Password';
                              } else if (value.length < 8) {
                                return 'Password Must Have At Least 8 Characters';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  onPressed: () {},
                                ),
                              ]),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text(
                                  'No account? Sign Up.',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 17),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterPage2.tag);
                                },
                              ),
                            ]),
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
