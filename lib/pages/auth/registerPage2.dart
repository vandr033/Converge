import 'package:flutter/material.dart';
import 'package:flutter_application/helper/helper_function.dart';
import 'package:flutter_application/interest_screen_1.dart';

import 'package:flutter_application/pages/auth/loginpage2.dart';
import 'package:flutter_application/services/auth_services.dart';
import 'package:flutter_application/verify.dart';
import 'package:flutter_application/widgets/widgets.dart';

class RegisterPage2 extends StatefulWidget {
  static String tag = 'Register-page-2';

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  String confPassword = '';

  bool _loading = false;
  AuthService auth = new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? (Center(
                child: CircularProgressIndicator(
                  color: Colors.blueGrey[700],
                ),
              ))
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
                        Container(
                            height: 142.5,
                            decoration: BoxDecoration(
                              //color: Colors.blue,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/Converge.png"),
                                //fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          'Get Started!',
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
                              } else if (!value.contains('fiu.edu')) {
                                return 'Please use your FIU Email Address';
                            } else {
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          height: 15,
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
                                hintText: 'Username',
                                fillColor: Color(0xff838383),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter A Username';
                            } else {
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(
                            height: 4,
                            thickness: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                            setState(() {
                              password = value;
                            });
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
                        )),
                        SizedBox(
                          height: 15,
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
                                hintText: 'Confirm Password',
                                fillColor: Color(0xff838383),
                                filled: true,
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                          onChanged: (value) {
                            setState(() {
                              confPassword = value;
                            });
                          },
                          validator: (value) {
                            if (confPassword != password) {
                              return 'Passwords Must Match';
                            }
                          },
                        )),
                        SizedBox(
                          height: 125,
                        ),
                        Row(
                          //row 8 - navigation circles
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: Color(
                                  0xff4589FF), //this is the color i want - F06449
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(Icons.circle,
                                size: 15, color: Color(0xffD9D9D9)),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(Icons.circle,
                                size: 15, color: Color(0xffD9D9D9)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
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
                                    register();
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
                            'Already Have An Account?',
                            style: TextStyle(color: Colors.black54, fontSize:17),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(loginPage2.tag);
                          },
                        ),
                            ]),

                      ],
                    ),
                  ),
                ),
              ));
  }

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      await auth
          .registerUserWithEmailandPassword(username, email, password)
          .then((value) async {
        await HelperFunctions.saveUserLoggedInStatus(true);
        await HelperFunctions.saveUserNameInStatus(username);
        await HelperFunctions.saveUserEmail(email);
        nextScreenReplace(context, VerifyScreen());
        if (value == true) {
          setState(() {
            _loading = false;
          });
        } else {
          showsnackbar(context, Colors.black, value);
          setState(() {
            _loading = false;
          });
        }
      });
    }
  }
}
