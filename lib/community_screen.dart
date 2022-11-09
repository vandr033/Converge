import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const List<String> screens = ['Create Event', 'Create Community'];
String? chosenScreen = 'Create Event';

class CommunityScreen extends StatefulWidget {
  static String tag = 'community-screen';
  @override
  CommunityScreenState createState() => CommunityScreenState();
}

class CommunityScreenState extends State<CommunityScreen> {
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
        body: Center(
          //this is our background. (body within body:SlidingUpPanel is our background, aka what's behind the panel.)
          child: Text(
              "Community Screen"), //this is just here for demonstrative purposes - this is the widget behind the sliding panel - therefore this is wrapped within the sliding up panel - it is our background.
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

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.panelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
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
          buildCommunityInfo(), //widget below.
          SizedBox(height: 30),
        ],
      );

  Widget buildCommunityInfo() => Container(
        //here i have created a container with a child column - you can fill the column will all of the rows and its children, or anything else, that you need.
        //this is all the stuff in our panel.

        padding: EdgeInsets.symmetric(horizontal: 24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              //example
              children: [
                SizedBox(
                    width: 226,
                    height: 46,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0XFFD7D9D7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      value: chosenScreen,
                      items: screens
                          .map((screen) => DropdownMenuItem<String>(
                              value: screen,
                              child: Text(
                                screen,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )))
                          .toList(),
                      onChanged: (screen) =>
                          setState(() => chosenScreen = screen),
                    )),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 114,
                  height: 46,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: '',
                        filled: true,
                        fillColor: Color(0XFFD7D9D7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Stack(
              //Row(
              //example
              children: [
                //Image Picker
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  elevation: 8.0,
                  child: Container(
                      alignment: Alignment(0, -.25),
                      height: 110,
                      width: 360,
                      decoration: image != null
                          ? BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: FileImage(image!), fit: BoxFit.fill))
                          : BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                      child: image != null
                          ? Icon(null)
                          : Icon(Icons.upload_rounded, color: Colors.white)),
                  onPressed: () {
                    pickImage();
                  },
                ),

                //white buffer between the circle image and rectangle immage
                Container(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),

                //Circle stacked ontop
                Container(
                  padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 75,
                      width: 75,
                      decoration: image != null
                          ? BoxDecoration(
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                  image: FileImage(image!), fit: BoxFit.fill))
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffD7D9D7),
                            ),
                      child: image != null
                          ? Icon(null)
                          : Icon(Icons.upload_rounded, color: Colors.white)),
                ),
              ],
              //),
            ),

            SizedBox(height: 0),

            Stack(
              children: [
                
                Container(
                  width: 360,
                  height: 46,
                  decoration: BoxDecoration(
                    //color: Color(0XFFD7D9D7),
                    color: Color(0xffD7D9D7),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: Icon(
                    Icons.shield_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                
                Container(
                  width: 360,
                  height: 46,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      icon: Icon(Icons.shield_outlined, size: 1,),
                        hintText: 'Community Guidelines:',
                        filled: false,
                        fillColor: Color(0XFFD7D9D7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                        labelText: '  Community Guidelines:',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                ),
                ),
                  

              ],
            ),

            SizedBox(height: 10),

            Row(
              //example
              children: [
                SizedBox(
                  width: 360,
                  height: 46,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Hosts:',
                        filled: true,
                        fillColor: Color(0XFFD7D9D7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                        labelText: '  Hosts:',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              //example
              children: [
                SizedBox(
                  width: 360,
                  height: 46,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Description:',
                        filled: true,
                        fillColor: Color(0XFFD7D9D7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                        labelText: '  Description:',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              //example
              children: [
                SizedBox(
                  width: 360,
                  height: 46,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: false,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: 'Category:',
                        filled: true,
                        fillColor: Color(0XFFD7D9D7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                        labelText: '  Category:',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            //enter post button here //used next button as template CHANGE THIS!!!!!!!!!!!!!!!!
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
                        //Navigator.of(context).pushNamed(InterestScreen2.tag);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      child: const Text(
                        'Post',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                )
              ],
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
