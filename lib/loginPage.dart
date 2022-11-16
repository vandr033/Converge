import 'package:auth_service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final AuthService _authService =
      FirebaseAuthService(authService: FirebaseAuth.instance);

  final db = FirebaseFirestore.instance;

  String _errorMessage = 'Error';

  void onChange() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    emailController.addListener(onChange);
    passwordController.addListener(onChange);
    final logo = Hero(
      tag: 'logo',
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 48.0,
        child: Image.asset('assets/1.png'),
      ),
    );

    final errorMessage = Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        '$_errorMessage',
        style: TextStyle(fontSize: 14, color: Colors.redAccent),
        textAlign: TextAlign.center,
      ),
    );

    final email = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter an email';
        } else if (!value.contains('@')) {
          return 'Please Enter An email in correct format';
        } else if (!value.contains('fiu.edu')) {
          return 'Please use your FIU email adress';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      autocorrect: false,
      controller: emailController,
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
    );

    final passwordTextform = TextFormField(
      autocorrect: false,
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter a Password';
        } else {
          return null;
        }
      },
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(node);
      },
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(12),
            backgroundColor: Colors.lightBlueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        onPressed: () async {
          if (_formkey.currentState != null) {
            if (_formkey.currentState!.validate()) {
              final userCredentials = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
              final user = userCredentials.user;
              print('UID:${user?.uid}');
              print('Display Name: ${user?.displayName}');
            }
          }
          final db = FirebaseFirestore.instance;
        },
        child: Text(
          'login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    final forgotLabel = TextButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final registerButton = Padding(
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
            padding: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
        onPressed: () {
          Navigator.of(context).pushNamed(RegisterPage.tag);
        },
        child: Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: _formkey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                logo,
                SizedBox(height: 12.0),
                email,
                SizedBox(height: 8.0),
                passwordTextform,
                SizedBox(height: 24.0),
                loginButton,
                registerButton,
                forgotLabel
              ],
            ),
          ),
        ));
  }

//implement sign in with firebase

}
