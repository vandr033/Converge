import 'package:flutter/material.dart';
import 'package:flutter_application/interest_screen_2.dart';

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
                  "See anything\nyou like?",
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
              height: 75,
            ),
            Row(
              //row 2 - buttons
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(75, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Music",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(200, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Academics",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(150, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Gaming",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(125, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Careers",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(200, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Outdoors",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(75, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Art",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(150, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Cooking",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(125, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Business",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(120, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Movies",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(155, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Traveling",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(155, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Parties",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xff4589FF), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0),
                  ),
                  minimumSize: Size(120, 40)
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Sports",
                    style: TextStyle(
                      color: Color(0xff4589FF),
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
                  color: Color(0xffF06449), //this is the color i want - F06449
                ),
                SizedBox(
                  width: 7,
                ),
                Icon(Icons.circle, size: 20, color: Color(0xffD9D9D9)),
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
