// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_application/HomePage.dart';
import 'package:flutter_application/event_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProfileScreen1 extends StatefulWidget {
  static String tag = 'profile-screen-1';
  @override
  ProfileScreen1State createState() => ProfileScreen1State();
}

class ProfileScreen1State extends State<ProfileScreen1> {
  File? image1;
  File? image2;

  var dropdownValue;

  Future pickImage1() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() => image1 = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  Future pickImage2() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() => image2 = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Stack(
                children: [
                  Expanded(
                    //flex: 1,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 125, 200, 0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Text(
                              "Jane Smith",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xffD7D9D7),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 125, 200, 0),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Icons",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
                              //color: Color(0xffD7D9D7),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Profile Banner Image Picker
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      elevation: 8.0,
                      child: Container(
                          alignment: Alignment(.90, -.75),
                          height: 110,
                          width: 360,
                          decoration: image1 != null
                              ? BoxDecoration(
                                  color: Color(0xffD7D9D7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  image: DecorationImage(
                                      image: FileImage(image1!),
                                      fit: BoxFit.fill))
                              : BoxDecoration(
                                  color: Color(0xffD7D9D7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                          child: image1 != null
                              ? Icon(null)
                              : Icon(Icons.upload_rounded,
                                  color: Colors.white)),
                      onPressed: () {
                        pickImage1();
                      },
                    ),
                  ),

                  //White Circle around it
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),

                  //Profile Picture Image Picker
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          height: 75,
                          width: 75,
                          decoration: image2 != null
                              ? BoxDecoration(
                                  color: Color(0xffD7D9D7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  image: DecorationImage(
                                      image: FileImage(image2!),
                                      fit: BoxFit.fill))
                              : BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD7D9D7),
                                ),
                          child: image2 != null
                              ? Icon(null)
                              : Icon(Icons.upload_rounded,
                                  color: Colors.white)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1, // default
                    child: Container(
                      width: 120,
                      height: 55,
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: Text(
                        "Foodie, gymrat, and\n"
                        "cinema enthusiast.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xffD7D9D7),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 135.0,
                    height: 45.0,
                    padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4589FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0))),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          softWrap: false,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 330,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Color(0xffD7D9D7),
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
