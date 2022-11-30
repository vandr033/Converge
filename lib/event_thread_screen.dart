import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/event_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventThreadScreen extends StatefulWidget {
  static String tag = 'event-thread-screen';
  @override
  EventThreadScreenState createState() => EventThreadScreenState();
}

class EventThreadScreenState extends State<EventThreadScreen> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height *
        0.1; //when we first come onto the page, panel will be 10% of our screen height - can modify if necessary.
    final panelHeightOpen = MediaQuery.of(context).size.height *
        0.8; //if you scroll panel all the way up, it will occupy 80% of the screen - can modify if necessary.

    return Scaffold(
      body: SlidingUpPanel(
        controller: panelController,
        maxHeight: panelHeightOpen, //max height of panel
        backdropEnabled: true,
        minHeight:
            panelHeightClosed, //min height of panel - can adjust if need be
        body: HomeScreen(),
        panelBuilder: (controller) => PanelWidget(
          panelController: panelController,
          controller: controller,
        ),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(18)), //rounded corners
      ),
    );
  }
}

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) => ListView(
        //ListView is a scrollable list of widgets arranged linearly.
        padding: EdgeInsets.zero,
        controller: widget.controller,
        children: <Widget>[
          SizedBox(height: 12),
          buildDragHandle(),
          SizedBox(height: 30),
          buildThreadInfo(), //widget below.
          SizedBox(height: 30),
        ],
      );

  Widget buildThreadInfo() {
    return Visibility(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Column(children: [
            Row(children: [
              SizedBox(
                width: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  color: Color(0xffD7D9D7),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/Rectangle 129.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Jane Smith",
                style: TextStyle(
                  color: Color(0xff3F3F3F),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 50,
              ),
              //Container(width:20, height:20, color:Colors.blue)
              Container(
                width: 73.0,
                height: 27.0,
                //padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4589FF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0))),
                    child: const Text(
                      'RSVP',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      softWrap: false,
                    )),
              ),
              SizedBox(width: 15),
              Icon(
                CupertinoIcons.heart_fill,
                color: Colors.red,
                size: 24.0,
              ),
              SizedBox(width: 15),
              Icon(Icons.bookmark_rounded, color: Colors.yellow, size: 24.0),
              SizedBox(height: 100),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 280, 0),
              child: Text(
                'Morning Run',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color(0xff3F3F3F),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                'Running & breakfast tomorrow! Come on out and enjoy some early' +
                    ' morning excercise around Tamiami Park by FIU. We will also be getting' +
                    ' some smoothie bowls at Tropical Smoothie Cafe. See you there!',
                textAlign: TextAlign.left,
                style: TextStyle(color: Color(0xff3F3F3F), fontSize: 12),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 270, 0),
              child: Text(
                'Whos going?',
                style: TextStyle(
                    color: Color(0xff3F3F3F),
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              //The other people
              children: [
                SizedBox(
                  width: 45,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        color: Color(0xffD7D9D7),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/Rectangle 61.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Sam Scott',
                      style: TextStyle(
                        color: Color(0xff3F3F3F),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 85,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        color: Color(0xffD7D9D7),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/Rectangle 62.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'itscorey',
                      style: TextStyle(
                        color: Color(0xff3F3F3F),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        color: Color(0xffD7D9D7),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                          image: AssetImage("assets/images/Rectangle 63.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Raul_Iglesias',
                      style: TextStyle(
                        color: Color(0xff3F3F3F),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 25,
              width: MediaQuery.of(context).size.width, //color: Colors.red,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xff4589FF),
                    Colors.white.withOpacity(0.0)
                  ])),
              child: Row(
                children: [
                  Icon(
                    Icons.place_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  Text(
                    "Tamiami Park, 7 AM - 8:30 AM",
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 300,
              width: 430,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Group 139.png'),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff4589FF), Colors.white.withOpacity(0.0)],
                ),
              ),
            ),
          ])),
    );
  }

  Widget buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 100,
            height: 3,
            decoration: BoxDecoration(
              color: Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onTap: togglePanel,
      );

  void togglePanel() => widget.panelController
          .isPanelOpen //this is working, but you have to click exactly on the skinny gray line for it to work... i wonder how this would translate to using the app on a real phone, hopefully would not be a problem.
      ? widget.panelController.close()
      : widget.panelController.open();
}
