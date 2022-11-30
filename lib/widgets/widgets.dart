import 'package:flutter/material.dart';

const textinputDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xFFD7D9D7),
  labelStyle: TextStyle(color: Colors.white),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD7D9D7), width: 2.0)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD7D9D7), width: 2.0)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD7D9D7), width: 2.0)),
);
void showsnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 10),
  ));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
