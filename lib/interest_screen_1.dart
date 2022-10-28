import 'package:flutter/material.dart';

class InterestScreen1 extends StatefulWidget {
  static String tag = 'interest-screen-1';
  @override
  InterestScreen1State createState() => InterestScreen1State();
}

class InterestScreen1State extends State<InterestScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(
          30, //try this and see how it looks
        ),
        child: Column(
          //column containing all of our rows.
          children: [
            //I believe we need 9 rows total...
            Row(
              //row 1 - text
              children: const [
                Text(
                  "See anything you like?",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              //want space between ours rows within our column.
              height: 30,
            ),
            Row(
              //row 2 - buttons
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 3 - buttons
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 4 - buttons
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 5 - buttons
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 6 - buttons
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 7 - buttons
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 8 - navigation circles
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 9 - "next" button
              children: [],
            ),
            const SizedBox(
              height: 30,
            ),
          ], //last row- end of children within column.
        ),
      ),
    );
  }
}
