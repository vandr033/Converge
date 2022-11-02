// ignore_for_file: prefer_const_constructors

import 'package:auth_service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_service/src/service/firebase_auth_service.dart' as fba;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/interest_screen_1.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  final emailTextController = new TextEditingController();
  final emailTextEditController = new TextEditingController();
  final lastNameTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();
  final confirmPasswordTextEditController = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final db = FirebaseFirestore.instance;

  //TODO: FIREBASE auth

  String _errorMessage = '';

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message!;
    });
  }

  void sendEmailVerification() {
    if (!auth.currentUser!.emailVerified) {
      auth.currentUser!.sendEmailVerification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formkey,
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 36, left: 24, right: 24),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '$_errorMessage',
                      style: TextStyle(fontSize: 14.0, color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        } else if (!value.contains('fiu.edu')) {
                          return 'Please use your FIU email adress';
                        }
                        return null;
                      },
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_firstNameFocus);
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      controller: lastNameTextEditController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      focusNode: _lastNameFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.length < 8 ||
                            value.contains('1')) {
                          return 'Password must be longer than 8 characters.';
                        }
                        return null;
                      },
                      autofocus: false,
                      obscureText: true,
                      controller: passwordTextEditController,
                      textInputAction: TextInputAction.next,
                      focusNode: _passwordFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocus);
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      controller: confirmPasswordTextEditController,
                      focusNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (passwordTextEditController.text.length > 8 &&
                            passwordTextEditController.text != value) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: () async {
                        try {
                          UserCredential result =
                              await auth.createUserWithEmailAndPassword(
                                  email: emailTextController.text,
                                  password: passwordTextEditController.text);
                          print(result.user?.uid.toString());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            var snackBar =
                                SnackBar(content: Text('Weak Password'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (e.code == 'email-already-in-use') {
                            print('email already in use');
                            print(auth.currentUser!.email);
                          }
                        } catch (e) {
                          print(e);
                        }
                        if (auth.currentUser != null) {
                          final user = <String, dynamic>{
                            "username":
                                lastNameTextEditController.text.toString(),
                            "UID": auth.currentUser?.uid,
                            "Sports": false,
                            "Music": false,
                          };

                          //adds user to collection "Users"
                          db.collection("users").add(user).then(
                              (DocumentReference doc) => print(
                                  'DocumentSnapshot added with ID: ${doc.id}'));
                          Navigator.of(context).pushNamed(InterestScreen1.tag);

                          // send email verification link if user was created
                          
                        }
                        //   _authService.createUserWithEmailAndPassword(
                        //       email: emailTextController.text,
                        //       password: passwordTextEditController.text);
                        //   print('Created An Account');
                        //   _authService.signInWithEmailAndPassword(
                        //       email: emailTextController.text,
                        //       password: passwordTextEditController.text);
                        //   print('logged in');
                        // } catch (e) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(content: Text(e.toString())));
                        // }

                        auth.sendPasswordResetEmail(
                            email: emailTextController.text);
                      },
                      child: Text('Sign Up'.toUpperCase(),
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.zero,
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black54),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ))
                ]),
          ),
        ));
  }

  currentUser() {
    final User? user = auth.currentUser;
    final uid = user!.uid.toString();
    return uid;
  }
}
