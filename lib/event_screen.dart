import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventScreen extends StatefulWidget {
  static String tag = 'event-screen';
  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height *
        0.1; //when we first come onto the page, panel will be 10% of our screen height - can modify if necessary.
    final panelHeightOpen = MediaQuery.of(context).size.height *
        0.8; //if you scroll panel all the way up, it will occupy 80% of the screen - can modify if necessary.

    return Scaffold(
      body: SlidingUpPanel(
        backdropEnabled: true,
        controller: panelController,
        maxHeight: panelHeightOpen, //max height of panel
        minHeight:
            panelHeightClosed, //min height of panel - can adjust if need be
        body: Center(
          //this is our background. (body within body:SlidingUpPanel is our background, aka what's behind the panel.)
          child: Text(
              "Event Screen"), //this is just here for demonstrative purposes - this is the widget behind the sliding panel - therefore this is wrapped within the sliding up panel - it is our background.
        ),
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

  PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  /*
  This stuff is currently under construction
  */

  File? image1; 
  File? image2;
  File? image3;
  File? image4;

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

   Future pickImage3() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() => image3 = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

   Future pickImage4() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() => image4 = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
        //ListView is a scrollable list of widgets arranged linearly.
        padding: EdgeInsets.zero,
        controller: widget.controller,
        children: <Widget>[
          SizedBox(height: 12),
          buildDragHandle(),
          SizedBox(height: 30),
          buildEventInfo(), //widget below.
          SizedBox(height: 30),
        ],
      );

  Widget buildEventInfo() => Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 184,
              width: double.infinity,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                MaterialButton(
                  elevation: 8.0,
                  child: Container(
                      height: 184,
                      width: 108,
                      decoration: image1 != null
                          ? BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: FileImage(image1!), fit: BoxFit.fill))
                          : BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                      child: image1 != null
                          ? Icon(null)
                          : Icon(Icons.upload_rounded, color: Colors.white)),
                  onPressed: () {
                    //File? image;
                    pickImage1();
                  },
                ),
                MaterialButton(
                  elevation: 8.0,
                  child: Container(
                      height: 184,
                      width: 108,
                      decoration: image2 != null
                          ? BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: FileImage(image2!), fit: BoxFit.fill))
                          : BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                      child: image2 != null
                          ? Icon(null)
                          : Icon(Icons.upload_rounded, color: Colors.white)),
                  onPressed: () {
                    pickImage2();
                  },
                ),
                
                MaterialButton(
                  elevation: 8.0,
                  child: Container(
                      height: 184,
                      width: 108,
                      decoration: image3 != null
                          ? BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: FileImage(image3!), fit: BoxFit.fill))
                          : BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                      child: image3 != null
                          ? Icon(null)
                          : Icon(Icons.upload_rounded, color: Colors.white)),
                  onPressed: () {
                    pickImage3();
                  },
                ),
                MaterialButton(
                  elevation: 8.0,
                  child: Container(
                      height: 184,
                      width: 108,
                      decoration: image4 != null
                          ? BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: FileImage(image4!), fit: BoxFit.fill))
                          : BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                      child: image4 != null
                          ? Icon(null)
                          : Icon(Icons.upload_rounded, color: Colors.white)),
                  onPressed: () {
                    pickImage4();
                  },
                ),
                SizedBox(height: 20),
              ]),
            ),
          ],
        ),
      );

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
