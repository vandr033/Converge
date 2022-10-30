import 'package:flutter/material.dart';

class InterestScreen2 extends StatefulWidget {
  static String tag = 'interest-screen-2';
  @override
  InterestScreen2State createState() => InterestScreen2State();
}

class InterestScreen2State extends State<InterestScreen2> {
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
            Row(
              //row 1 - text
              children: const [
                Text(
                  "Check out these\ncommunities!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black, //text color black
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              //want space between ours rows within our column.
              height: 30,
            ),
            //list here
            Expanded(
              child: ListView.builder(
                itemCount: 5, //5 listed commmunities on this page.
                itemBuilder: (_, i) {
                  return Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/design_buddies.png"),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: const [Text("Test")],
                            ),
                            Row(
                              children: const [
                                Text("Test"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        
                      ),
                    ],
                  );
                },
              ),
            ),
          ], //last row- end of children within column.
        ),
      ),
    );
  }
}
