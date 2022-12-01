// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/event_screen.dart';

class InterestScreen2 extends StatefulWidget {
  static String tag = 'interest-screen-2';
  @override
  InterestScreen2State createState() => InterestScreen2State();
}

class InterestScreen2State extends State<InterestScreen2> {
  List<String> images = [
    'assets/design_buddies.png',
    'assets/Rectangle 155.png',
    'assets/Rectangle 156.png',
    'assets/Rectangle 157.png',
    'assets/Rectangle 158.png',
  ];
  List<String> community_names = [
    'Design Buddies',
    'FIU Crypto',
    'Volleyball',
    'FIU Formula 1',
    'Startup FIU'
  ];

  List<String> community_descriptions = [
    'UI/UX Design For Everyone',
    'Crypto Can be Easy, Join us!',
    'Seat,,sand, & tears (of joy)',
    'F1 Watch Parties',
    'Have A Business Idea? Join!'
  ];

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
            const SizedBox(
              height: 30,
            ),
            Row(
              //row 1 - text
              children: const [
                Text(
                  "Check out these\ncommunities!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF3F3F3F), //text color black
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            //list here
            Expanded(
              child: ListView.builder(
                itemCount: images.length, //5 listed commmunities on this page.
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 75,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[index].toString()),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  community_names[index],
                                  style: TextStyle(
                                    fontFamily: 'IBM-Plex',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                    color: Color.fromRGBO(69, 137, 255, 1),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  community_descriptions[index],
                                  style: TextStyle(
                                      fontFamily: 'IBM-Plex',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xFF3F3F3F),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(69, 137, 255, 1),
                                  padding: EdgeInsets.all(12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                onPressed: () {
                                  SnackBar snackBar =
                                      SnackBar(content: Text('Added Interest'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: Text('Follow',
                                    style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              //row 8 - navigation circles
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.circle, size: 20, color: Color(0xffD9D9D9)),
                SizedBox(
                  width: 7,
                ),
                Icon(
                  Icons.circle,
                  size: 20,
                  color: Color(0xffD9D9D9), //this is the color i want - F06449
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(Icons.circle, size: 20, color: Color(0xff4589FF)),
              ],
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 10,
                )
              ],
            ),
            Row(
                //row 9 - "next" button
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //The actual formatting of the 'Next' button and everything we do for it
                  SizedBox(
                    width: 250.0,
                    height: 40.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(EventScreen.tag);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4589FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                  )
                ])
          ], //last row- end of children within column.
        ),
      ),
    );
  }
}
