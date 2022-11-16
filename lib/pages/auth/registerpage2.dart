import 'package:flutter/material.dart';
import 'package:flutter_application/helper/helper_function.dart';
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

  AuthService auth = AuthService();
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
                        // ignore: prefer_const_constructors
                        Text(
                          'Welcome Back',
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
                          decoration: textinputDecoration.copyWith(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 10, 20, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9)),
                              hintText: 'Username',
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
                              return 'Please Enter a username';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Divider(
                          height: 4,
                          thickness: 1.5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textinputDecoration.copyWith(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              hintText: 'Password',
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
                              return 'Please Enter a Password';
                            } else if (value.length < 8) {
                              return 'Password Must Have at least 6 characters';
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
                              return 'passwords must match';
                            }
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          child: Text(
                            'Already Have An Account?',
                            style: TextStyle(color: Colors.black54),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(loginPage2.tag);
                          },
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        Row(
                          //row 8 - navigation circles
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.circle,
                              size: 20,
                              color: Color(
                                  0xffF06449), //this is the color i want - F06449
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(Icons.circle,
                                size: 20, color: Color(0xffD9D9D9)),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(Icons.circle,
                                size: 20, color: Color(0xffD9D9D9)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  width: MediaQuery.of(context).size.width,
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
                                      ))),
                            ),
                          ],
                        ),
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
