import 'package:flutter/material.dart';
import 'package:flutter_application/interest_screen_2.dart';

class InterestScreen1 extends StatefulWidget {
  static String tag = 'interest-screen-1';
  @override
  InterestScreen1State createState() => InterestScreen1State();
}

class InterestScreen1State extends State<InterestScreen1> {
  bool _academicsHasBeenPressed = false;
  bool _musicHasBeenPressed = false;
  bool _gamingHasBeenPressed = false;
  bool _careersHasBeenPressed = false;
  bool _outdoorsHasBeenPressed = false;
  bool _artHasBeenPressed = false;
  bool _cookingHasBeenPressed = false;
  bool _businessHasBeenPressed = false;
  bool _moviesHasBeenPressed = false;
  bool _travellingHasBeenPressed = false;
  bool _partiesHasBeenPressed = false;
  bool _sportsHasBeenPressed = false;
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
            SizedBox(
              height: 50,
            ),
            //I believe we need 9 rows total...
            Row(
              //row 1 - text
              children: const [
                
                Text(
                  "See anything\nyou like?",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF3F3F3F), //text color black
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              //want space between ours rows within our column.
              height: 70,
            ),
            Row(
              //row 2 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: _musicHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(95, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(95, 40)),
                  onPressed: () => {
                    setState(() {
                      _musicHasBeenPressed = !_musicHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Music",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //want space between each button
                  width: 10,
                ),
                OutlinedButton(
                  style: _academicsHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(180, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(180, 40)),
                  onPressed: () => {
                    setState(() {
                      _academicsHasBeenPressed = !_academicsHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Academics",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              //row 3 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: _gamingHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(150, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(150, 40)),
                  onPressed: () => {
                    setState(() {
                      _gamingHasBeenPressed = !_gamingHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Gaming",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //want space between each button
                  width: 10,
                ),
                OutlinedButton(
                  style: _careersHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(125, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(125, 40)),
                  onPressed: () => {
                    setState(() {
                      _careersHasBeenPressed = !_careersHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Careers",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              //row 4 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: _outdoorsHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(200, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(200, 40)),
                  onPressed: () => {
                    setState(() {
                      _outdoorsHasBeenPressed = !_outdoorsHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Outdoors",
                    style: TextStyle(
                      //r
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //want space between each button
                  width: 10,
                ),
                OutlinedButton(
                  style: _artHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(75, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(75, 40)),
                  onPressed: () => {
                    setState(() {
                      _artHasBeenPressed = !_artHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Art",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              //row 5 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: _cookingHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(150, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(150, 40)),
                  onPressed: () => {
                    setState(() {
                      _cookingHasBeenPressed = !_cookingHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Cooking",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //want space between each button
                  width: 10,
                ),
                OutlinedButton(
                  style: _businessHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(125, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(125, 40)),
                  onPressed: () => {
                    setState(() {
                      _businessHasBeenPressed = !_businessHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Business",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              //row 6 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: _moviesHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(120, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(120, 40)),
                  onPressed: () => {
                    setState(() {
                      _moviesHasBeenPressed = !_moviesHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Movies",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //want space between each button
                  width: 10,
                ),
                OutlinedButton(
                  style: _travellingHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(155, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(155, 40)),
                  onPressed: () => {
                    setState(() {
                      _travellingHasBeenPressed = !_travellingHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Traveling",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              //row 7 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: _partiesHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(155, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(155, 40)),
                  onPressed: () => {
                    setState(() {
                      _partiesHasBeenPressed = !_partiesHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Parties",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  //want space between each button
                  width: 10,
                ),
                OutlinedButton(
                  style: _sportsHasBeenPressed
                      ? OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          minimumSize: Size(120, 40))
                      : OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff4589FF), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          foregroundColor: Color(0xff4589FF),
                          minimumSize: Size(120, 40)),
                  onPressed: () => {
                    setState(() {
                      _sportsHasBeenPressed = !_sportsHasBeenPressed;
                    })
                  },
                  child: const Text(
                    "Sports",
                    style: TextStyle(
                      //color: Color(0xff4589FF),
                      fontSize: 20,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              //row 8 - navigation circles
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.circle,
                  size: 20,
                  color: Color(0xffD9D9D9), //this is the color i want - F06449
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(Icons.circle, size: 20, color: Color(0xff4589FF)),
                SizedBox(
                  width: 7,
                ),
                Icon(Icons.circle, size: 20, color: Color(0xffD9D9D9)),
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
                  height: 40.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(InterestScreen2.tag);
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
              ],
            ),
          ], //last row- end of children within column.
        ),
      ),
    );
  }
}
