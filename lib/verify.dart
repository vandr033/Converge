import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/interest_screen_1.dart';
import 'package:flutter_application/registerPage.dart';
import 'dart:async' show Future, Timer;





class VerifyScreen extends StatefulWidget {
  static String tag = 'verify';
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final lastNameTextEditController = new TextEditingController();
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;
  
  final _formkey = GlobalKey<FormState>();
  
  
  @override
  void initState() {
      user = FirebaseAuth.instance.currentUser!;
      user.sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 3), (timer) { 

      });
      super.initState();
      
  }

  @override
  void dispose() {
      timer.cancel();
      super.dispose();
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
          padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
          children: <Widget>[
          Padding (
            padding: const EdgeInsets.only(top: 40),
            child: Text('An email was send to ${user.email.toString()}, please verify by checking the link.', 
            style: const TextStyle(color: Colors.black)),
          ),
          Padding (padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
                
              ), onPressed: () { 
                user.sendEmailVerification(); 
               },
              child: const Text('Resend Verification', style: TextStyle(color: Colors.white)), ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: TextButton(
            child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black54),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            ))
        ]),
        
    )),
    appBar: AppBar(
        title: const Text('Verification Page'),
        ),
    );
  }
  
                

  Future<void> checkEmailVerified() async {

      user = FirebaseAuth.instance.currentUser!;
      await user.reload();
      //Waits to see if user has verified email using the link
      if (user.emailVerified == true) {
          timer.cancel();
          
          if (auth.currentUser != null) {
              final user = <String, dynamic>{
              "username": lastNameTextEditController.text.toString(),
              "UID": auth.currentUser?.uid,
              "Sports": false,
              "Music": false,
              };
              //adds user to collection "Users"
              db.collection("users").add(user).then(
              (DocumentReference doc) => print(
              'DocumentSnapshot added with ID: ${doc.id}'));
              
            
      }
         
    }
    Navigator.of(context).pushNamed(InterestScreen1.tag);
  }
}