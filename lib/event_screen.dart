// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'data/user_data.dart';

List<String> screens = ['Create Event', 'Create Community'];
String chosenScreen = 'Create Event';
DateTime date = DateTime.now();
DateTime time = DateTime.now();

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
  Drop down 
  */
  String? _selected;

  List<Map> _myJson = [
    {
      'id': '1',
      'image': 'assets/community_logos/hamburger_logo.png',
      'name': 'Foodies'
    },
    {
      'id': '2',
      'image': 'assets/community_logos/globe_trotters_logo.png',
      'name': 'Globetrotters'
    },
    {
      'id': '3',
      'image': 'assets/community_logos/musicians_logo.png',
      'name': 'Musicians'
    },
    {
      'id': '4',
      'image': 'assets/community_logos/einsteins_logo.png',
      'name': 'Einsteins'
    },
  ];

  /*
  Image picker 
  */

  File? image1;
  File? image2;
  File? image3;
  File? image4;
  bool vis = false;

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

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          setState(() {
                            date = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                      child: const Text('OK'),
                      onPressed: () => {} //Navigator.of(ctx).pop(),
                      )
                ],
              ),
            ));
  }

  void _showTimePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (val) {
                          setState(() {
                            time = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                      child: const Text('OK'),
                      onPressed: () => {} //Navigator.of(ctx).pop(),
                      )
                ],
              ),
            ));
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
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                    width: 200,
                    //height: 100,
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
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )))
                          .toList(),
                      onChanged: (screen) =>
                          setState(() => chosenScreen = screen!),
                    )),
                SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 100,
                  //height: 100,
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
                        alignLabelWithHint: true,
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              //this contains our image picker
              height: 184,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
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
                                    image: FileImage(image1!),
                                    fit: BoxFit.fill))
                            : BoxDecoration(
                                color: Color(0xffD7D9D7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                        child: image1 != null
                            ? Icon(null)
                            : Icon(Icons.upload_rounded, color: Colors.white)),
                    onPressed: () {
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
                                    image: FileImage(image2!),
                                    fit: BoxFit.fill))
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
                                    image: FileImage(image3!),
                                    fit: BoxFit.fill))
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
                                    image: FileImage(image4!),
                                    fit: BoxFit.fill))
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
                ],
              ),
            ),
            SizedBox(height: 20),
            //SizedBox(height: 10),
            Row(
              //this is our "event starts" box
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 330,
                  height: 46.0,
                  child: Card(
                    color: Color(0XFFD7D9D7),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            width: 95,
                            height: 20,
                            child: Text(
                              "Event starts: ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        SizedBox(
                          width: 100,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () => _showDatePicker(this.context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: Text(date != null
                                ? DateFormat.yMd().format(date)
                                : 'No Date!'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 93,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () => _showTimePicker(this.context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: Text(time != null
                                ? DateFormat.jm().format(time)
                                : 'No Time!'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                //this is our "event ends" box
                width: 330,
                height: 46.0,
                child: Card(
                  color: Color(0XFFD7D9D7),
                  child: Row(children: [
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: 95,
                        height: 20,
                        child: Text(
                          "Event ends: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        )),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () => _showDatePicker(this.context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        child: Text(date != null
                            ? DateFormat.yMd().format(date)
                            : 'No Date!'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 93,
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () => _showTimePicker(this.context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        child: Text(time != null
                            ? DateFormat.jm().format(time)
                            : 'No Time!'),
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
            SizedBox(height: 10),
            Row(
              //this contains our host drop down.
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xffD7D9D7),
                    padding: EdgeInsets.all(10),
                    /*decoration: BoxDecoration(borderRadius:
                                          BorderRadius.all(Radius.circular(20)),*/
                    child: TypeAheadField<User?>(
                      //Here we use <User> because that is what we are autocompleting for.
                      hideOnEmpty: true,
                      //TypeAheadField - A TextField that displays a list of suggestions as the user types.
                      //hideSuggestionsOnKeyboardHide: false,
                      textFieldConfiguration: TextFieldConfiguration(
                        decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.search, color: Color(0xff828382)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                          ),
                          hintText: 'Hosts: ',
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff828382),
                              fontWeight: FontWeight.w700),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        color: Color(0xffD7D9D7),
                      ),
                      suggestionsCallback: UserData
                          .getSuggestions, //we get suggestions from UserData
                      itemBuilder: (context, User? suggestion) {
                        final user = suggestion!;

                        return ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(user.imageUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(user.name),
                        );
                      },
                      noItemsFoundBuilder: (context) => Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'No Users Found.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      onSuggestionSelected: (User? suggestion) {
                        final user =
                            suggestion!; //the suggestion that we selected is stored in user variable.
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              //this is our community drop down.
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            hint: Text('Select Community'),
                            value: _selected,
                            onChanged: (newValue) {
                              setState(() {
                                _selected = newValue;
                              });
                            },
                            items: _myJson.map(
                              (categoryItem) {
                                return DropdownMenuItem(
                                  value: categoryItem['id'].toString(),
                                  child: Row(
                                    children: [
                                      Image.asset(categoryItem['image'],
                                          width: 30),
                                      Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(categoryItem['name']))
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height:10),
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
