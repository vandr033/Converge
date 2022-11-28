// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application/HomePage.dart';
import 'package:flutter_application/community_screen.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';
import 'data/user_data.dart';

List<String> screens = ['Create Event', 'Create Community'];
String whenEventchosenScreen = 'Create Event';
String? chosenScreen = 'Create Community';
DateTime startDate = DateTime.now();
DateTime startTime = DateTime.now();
DateTime endDate = DateTime.now();
DateTime endTime = DateTime.now();
bool eventInfoVisible = false;
bool comInfoVisible = true;
int imageIndex = 0;

final pages = [
  HomeScreen(),
  ProfileScreen(),
  ProfileScreen2(),
  UPEStory(),
];

class EventScreen extends StatefulWidget {
  static String tag = 'event-screen';
  @override
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  final eventPanelController = PanelController();

  var bottomNavVis = true;

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final eventPanelHeightClosed = MediaQuery.of(context).size.height *
        0; //when we first come onto the page, panel will be 10% of our screen height - can modify if necessary.
    final eventPanelHeightOpen = MediaQuery.of(context).size.height *
        0.8; //if you scroll panel all the way up, it will occupy 80% of the screen - can modify if necessary.

    return Scaffold(
      body: SlidingUpPanel(
        onPanelClosed: () {
          setState(() {
            bottomNavVis = true;
          });
        },
        onPanelOpened: () {
          setState(() {
            bottomNavVis = false;
          });
        },
        backdropEnabled: true,
        controller: eventPanelController,
        maxHeight: eventPanelHeightOpen, //max height of panel
        minHeight:
            eventPanelHeightClosed, //min height of panel - can adjust if need be
        body: pages[index],
        panelBuilder: (controller) => PanelWidget(
          comPanelController: eventPanelController,
          eventController: controller,
        ),
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(18)), //rounded corners
      ),
      bottomNavigationBar: Visibility(
        visible: bottomNavVis,
        maintainState: true,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromRGBO(63, 63, 63, 1),
              borderRadius: BorderRadius.all(Radius.circular(0))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    eventPanelController.close();
                    index = 0;
                  });
                },
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    eventPanelController.close();
                    index = 0;
                  });
                },
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    index = 0;
                    eventPanelController.open();
                  });
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    eventPanelController.close();
                    index = 0;
                  });
                },
                icon: Icon(
                  Icons.chat_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    eventPanelController.close();
                    index = 1;
                  });
                },
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PanelWidget extends StatefulWidget {
  final ScrollController eventController;
  final PanelController comPanelController;

  PanelWidget({
    Key? key,
    required this.eventController,
    required this.comPanelController,
  }) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  /*
  Drop down 
  */
  String? _eventSelected;
  String? _comSelected;
  List<Map> _comunJson = [
    {
      'id': '1',
      'image': 'assets/category_logos/sports_logo.png',
      'name': 'Sports'
    },
    {
      'id': '2',
      'image': 'assets/category_logos/travel_logo.png',
      'name': 'Travel'
    },
    {
      'id': '3',
      'image': 'assets/category_logos/music_logo.png',
      'name': 'Music'
    },
    {
      'id': '4',
      'image': 'assets/category_logos/school_logo.png',
      'name': 'School'
    },
  ];
  List<Map> _eventJson = [
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
  File? communityImage1;
  File? communityImage2;
  File? eventImage1;
  File? eventImage2;
  File? eventImage3;
  File? eventImage4;

  var dropdownValue;

  String eventHostName = '';
  String communityHostName = '';
  bool eventExistsHost = false;
  bool communityExistsHost = false;

  String locationName = '';
  bool locationVisible = false;

  bool selected = false;
  Future communityPickImage1() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() => communityImage1 = imageTemp);
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

      setState(() => communityImage2 = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  Future eventPickImage1() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() {
        eventImage1 = imageTemp;
        imageIndex = 1;
      });
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  Future eventPickImage2() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() {
        setState(() {
          eventImage2 = imageTemp;
          imageIndex = 2;
        });
      });
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  Future eventPickImage3() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() {
        setState(() {
          eventImage3 = imageTemp;
          imageIndex = 3;
        });
      });
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  Future eventPickImage4() async {
    try {
      final imageGrab =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (imageGrab == null) return;

      final imageTemp = File(imageGrab.path);

      setState(() => eventImage4 = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to get image: $e');
    }
  }

  void eventStartDatePicker(ctx) {
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
                            startDate = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(ctx, rootNavigator: true).pop(ctx),
                    },
                  )
                ],
              ),
            ));
  }

  void eventStartTimePicker(ctx) {
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
                            startTime = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(ctx, rootNavigator: true).pop(ctx),
                    },
                  )
                ],
              ),
            ));
  }

  void eventEndDatePicker(ctx) {
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
                            endDate = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(ctx, rootNavigator: true).pop(ctx),
                    },
                  )
                ],
              ),
            ));
  }

  void eventEndTimePicker(ctx) {
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
                            endTime = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(ctx, rootNavigator: true).pop(ctx),
                    },
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) => ListView(
        //ListView is a scrollable list of widgets arranged linearly.
        padding: EdgeInsets.zero,
        controller: widget.eventController,
        children: <Widget>[
          SizedBox(height: 12),
          buildDragHandle(),
          SizedBox(height: 30),
          buildEventInfo(), //widget below.
          buildCommunityInfo(),
          SizedBox(height: 30),
        ],
      );

  Widget buildEventInfo() {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Visibility(
      visible: eventInfoVisible,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                    flex: 6, // default
                    child: Container(
                      // required field
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFF838383),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: 226,
                      height: 48,

                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(12.0),
                          dropdownColor: Color(0xFF838383),
                          style: const TextStyle(
                              color: Colors.white, //<-- SEE HERE
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          value: whenEventchosenScreen,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white, // <-- SEE HERE
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != dropdownValue) {
                              switch (newValue) {
                                case 'Create Event':
                                  //Navigator.of(context).push(MaterialPageRoute(
                                  //builder: (context) => EventScreen()));
                                  break;
                                case 'Create Community':
                                  //Navigator.of(context).push(MaterialPageRoute(
                                  //  builder: (context) => CommunityScreen()));
                                  setState(() {
                                    eventInfoVisible = false;
                                    comInfoVisible = true;
                                  });
                                  break;
                              }
                            }
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['Create Event', 'Create Community']
                              .map<DropdownMenuItem<String>>(
                                  (String chosenScreen) {
                            return DropdownMenuItem<String>(
                              value: chosenScreen,
                              child: Text(
                                chosenScreen,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 0, // default
                  child: Container(
                    width: 20,
                  ), // required field
                ),
                Expanded(
                  flex: 4, // default
                  child: Container(
                    width: 114,
                    height: 48,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Color(0xFF838383),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Container(
              //this contains our image picker
              height: 184,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    elevation: 8.0,
                    child: Container(
                        height: 184,
                        width: 108,
                        decoration: eventImage1 != null
                            ? BoxDecoration(
                                color: Color(0xFF838383),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: FileImage(eventImage1!),
                                    fit: BoxFit.fill))
                            : BoxDecoration(
                                color: Color(0xFF838383),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                        child: eventImage1 != null
                            ? Icon(null)
                            : Icon(Icons.upload_rounded, color: Colors.white)),
                    onPressed: () {
                      if (eventImage1 != null) {
                        setState(() {
                          eventImage1 = eventImage2;
                          eventImage2 = eventImage3;
                          eventImage3 = eventImage4;
                          eventImage4 = null;
                          imageIndex = imageIndex - 1;
                        });
                      } else {
                        if (imageIndex == 0) {
                          eventPickImage1();
                        }
                      }
                    },
                  ),
                  MaterialButton(
                    elevation: 8.0,
                    child: Container(
                        height: 184,
                        width: 108,
                        decoration: eventImage2 != null
                            ? BoxDecoration(
                                color: Color(0xFF838383),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: FileImage(eventImage2!),
                                    fit: BoxFit.fill))
                            : imageIndex == 1
                                ? BoxDecoration(
                                    color: Color(0xFF838383),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                        child: eventImage2 != null
                            ? Icon(null)
                            : Icon(Icons.upload_rounded, color: Colors.white)),
                    onPressed: () {
                      if (eventImage2 != null) {
                        setState(() {
                          eventImage2 = eventImage3;
                          eventImage3 = eventImage4;
                          eventImage4 = null;
                          imageIndex = imageIndex - 1;
                        });
                      } else {
                        if (imageIndex == 1) {
                          eventPickImage2();
                        }
                      }
                    },
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    elevation: 8.0,
                    child: Container(
                        height: 184,
                        width: 108,
                        decoration: eventImage3 != null
                            ? BoxDecoration(
                                color: Color(0xFF838383),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: FileImage(eventImage3!),
                                    fit: BoxFit.fill))
                            : imageIndex == 2
                                ? BoxDecoration(
                                    color: Color(0xFF838383),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                        child: eventImage3 != null
                            ? Icon(null)
                            : Icon(Icons.upload_rounded, color: Colors.white)),
                    onPressed: () {
                      if (eventImage3 != null) {
                        setState(() {
                          eventImage3 = eventImage4;
                          eventImage4 = null;
                          imageIndex = imageIndex - 1;
                        });
                      } else {
                        if (imageIndex == 2) {
                          eventPickImage3();
                        }
                      }
                    },
                  ),
                  MaterialButton(
                    elevation: 8.0,
                    child: Container(
                        height: 184,
                        width: 108,
                        decoration: eventImage4 != null
                            ? BoxDecoration(
                                color: Color(0xFF838383),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: FileImage(eventImage4!),
                                    fit: BoxFit.fill))
                            : imageIndex == 3
                                ? BoxDecoration(
                                    color: Color(0xFF838383),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))
                                : BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                        child: eventImage4 != null
                            ? Icon(null)
                            : Icon(Icons.upload_rounded, color: Colors.white)),
                    onPressed: () {
                      if (eventImage4 != null) {
                        setState(() {
                          eventImage4 = null;
                          imageIndex = 2;
                        });
                      } else {
                        if (imageIndex == 3) {
                          eventPickImage4();
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),

            /*
              Google Places dropdown here. 
              */

            Row(
              //example
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 360,
                    height: 46,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: false,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.place_outlined,
                            size: 23, color: Colors.white),
                        contentPadding: EdgeInsets.zero,
                        hintText: "Add Location",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: Color(0xFF838383),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        alignLabelWithHint: false,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selected = false;
                        });
                        applicationBloc.searchPlaces(value);
                      },
                    ),
                  ),
                ),
              ],
            ),

            if (applicationBloc.searchResults != null &&
                applicationBloc.searchResults?.length != 0 &&
                selected == false)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  color: Color(0xFF838383),
                ),
                height: 300,
                child: ListView.builder(
                  itemCount: applicationBloc.searchResults!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          setState(() {
                            selected = true;
                            locationVisible = true;
                            locationName = applicationBloc
                                .searchResults![index].description;
                          });
                        },
                        title: Text(
                            applicationBloc.searchResults![index].description,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700)));
                  },
                ),
              ),

            Visibility(
                visible: locationVisible,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                          side: BorderSide(color: Color(0xff4589FF)))),
                  onPressed: () {
                    setState(() {
                      locationVisible = false;
                      locationName = '';
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(locationName),
                      Icon(
                        Icons.close,
                        color: Colors.grey,
                      )
                    ],
                  ),
                )),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: SizedBox(
                      width: 363,
                      height: 46.0,
                      child: Container(
                        width: 115,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Color(0xFF838383),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: [
                            // SizedBox(
                            //   width: 30,
                            // ),
                            SizedBox(
                                width: 115,
                                height: 15,
                                child: Text(
                                  "\t\t Event starts: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                )),
                            //spacing between eve start and white boxes
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 95,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () =>
                                    eventStartDatePicker(this.context),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Text(
                                  startDate != null
                                      ? DateFormat.yMMMd().format(startDate)
                                      : 'No Date!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 70,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () =>
                                    eventStartTimePicker(this.context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Text(
                                  startDate != null
                                      ? DateFormat.jm().format(startTime)
                                      : 'No Time!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    child: SizedBox(
                      width: 363,
                      height: 46.0,
                      child: Container(
                        width: 115,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Color(0xFF838383),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 115,
                                height: 15,
                                child: Text(
                                  "\t\t Event ends: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                )),
                            SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 95,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () =>
                                    eventEndDatePicker(this.context),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Text(
                                  endDate != null
                                      ? DateFormat.yMMMd().format(endDate)
                                      : 'No Date!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 70,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () =>
                                    eventEndTimePicker(this.context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.grey,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0)),
                                ),
                                child: Text(
                                  endTime != null
                                      ? DateFormat.jm().format(endTime)
                                      : 'No Time!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            //this is where host goes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //this contains our host drop down.
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 360,
                    height: 55,
                    child: TypeAheadField<User?>(
                      //Here we use <User> because that is what we are autocompleting for.
                      direction: AxisDirection.up,
                      hideOnEmpty: true,
                      //TypeAheadField - A TextField that displays a list of suggestions as the user types.
                      //hideSuggestionsOnKeyboardHide: false,
                      textFieldConfiguration: TextFieldConfiguration(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                          ),
                          hintText: 'Hosts: ',
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          filled: true,
                          fillColor: Color(0xFF838383),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                        color: Color(0xFF838383),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suggestionsCallback: UserData
                          .getSuggestions, //we get suggestions from UserData
                      itemBuilder: (context, User? suggestion) {
                        final user = suggestion!;

                        return ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(user.imageUrl),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: Text(user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
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
                        final user = suggestion!;
                        setState(
                          () {
                            eventHostName = user.name;
                            eventExistsHost = true;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: eventExistsHost,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                          side: BorderSide(color: Color(0xff4589FF)))),
                  onPressed: () {
                    setState(() {
                      eventExistsHost = false;
                      eventHostName = '';
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(eventHostName),
                      Icon(
                        Icons.close,
                        color: Colors.grey,
                      )
                    ],
                  ),
                )),
            SizedBox(height: 5),

            Row(
              children: [
                Expanded(
                  flex: 1, // default
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF838383),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: 360,
                    height: 46,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Padding(
                          padding: EdgeInsets.only(left: 1.0),
                          child: Text('Select Community:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(12.0),
                        dropdownColor: Color(0xFF838383),
                        style: const TextStyle(
                            color: Colors.white, //<-- SEE HERE
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white, // <-- SEE HERE
                        ),
                        value: _eventSelected,
                        onChanged: (newValue) {
                          setState(() {
                            _eventSelected = newValue;
                          });
                        },
                        items: _eventJson.map(
                          (categoryItem) {
                            return DropdownMenuItem(
                              value: categoryItem['id'].toString(),
                              child: Row(
                                children: [
                                  Image.asset(categoryItem['image'], width: 30),
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

            SizedBox(height: 15),

            //Post Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 250.0,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.comPanelController.close();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff4589FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      child: const Text(
                        'Post',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///COMMUNITY!
  //////////////////////////////////////////////////////////////////

  Widget buildCommunityInfo() => Visibility(
        visible: comInfoVisible,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                //example
                children: [
                  Expanded(
                      flex: 6, // default
                      child: Container(
                        // required field
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xFF838383),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        width: 226,
                        height: 48,

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(12.0),
                            dropdownColor: Color(0xFF838383),
                            style: const TextStyle(
                                color: Colors.white, //<-- SEE HERE
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            value: chosenScreen,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white, // <-- SEE HERE
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != dropdownValue) {
                                switch (newValue) {
                                  case 'Create Community':
                                    //Navigator.of(context).push(MaterialPageRoute(
                                    //builder: (context) => CommunityScreen()));
                                    break;
                                  case 'Create Event':
                                    setState(() {
                                      eventInfoVisible = true;
                                      comInfoVisible = false;
                                    });
                                    break;
                                }
                              }
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Create Community', 'Create Event']
                                .map<DropdownMenuItem<String>>(
                                    (String chosenScreen) {
                              return DropdownMenuItem<String>(
                                value: chosenScreen,
                                child: Text(
                                  chosenScreen,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 0, // default
                    child: Container(
                      width: 20,
                    ), // required field
                  ),
                  Expanded(
                    flex: 4, // default
                    child: Container(
                      width: 114,
                      height: 48,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Color(0xFF838383),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          alignLabelWithHint: false,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //SizedBox(height: 10),

              Stack(
                //Row(
                //example
                children: [
                  //Image Picker
                  Positioned.fill(
                    //top: 0,
                    right: 0,
                    left: 0,
                    //bottom: 0,
                    //flex: 1,
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      elevation: 8.0,
                      child: Container(
                          alignment: Alignment(.90, -.75),
                          height: 110,
                          width: 360,
                          decoration: communityImage1 != null
                              ? BoxDecoration(
                                  color: Color(0xFF838383),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  image: DecorationImage(
                                      image: FileImage(communityImage1!),
                                      fit: BoxFit.fill))
                              : BoxDecoration(
                                  color: Color(0xFF838383),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                          child: communityImage1 != null
                              ? Icon(null)
                              : Icon(Icons.upload_rounded,
                                  color: Colors.white)),
                      onPressed: () {
                        communityPickImage1();
                      },
                    ),
                  ),

                  //white buffer between the circle image and rectangle immage
                  Positioned(
                    //flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 85,
                        width: 85,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),

                  //Circle stacked ontop
                  Positioned(
                    //flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          height: 75,
                          width: 75,
                          decoration: communityImage2 != null
                              ? BoxDecoration(
                                  color: Color(0xFF838383),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  image: DecorationImage(
                                      image: FileImage(communityImage2!),
                                      fit: BoxFit.fill))
                              : BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF838383),
                                ),
                          child: communityImage2 != null
                              ? Icon(null)
                              : Icon(Icons.upload_rounded,
                                  color: Colors.white)),
                    ),
                  ),
                ],
                //),
              ),

              SizedBox(height: 10),

              Stack(
                children: [
                  Positioned(
                    //flex: 1,
                    child: Container(
                      width: 360,
                      height: 46,
                      decoration: BoxDecoration(
                        //color: Colors.green,
                        color: Color(0xFF838383),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  Positioned(
                    //flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Icon(
                        Icons.shield_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    //flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Icon(
                        Icons.check,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    //flex: 1,
                    child: Container(
                      width: 360,
                      height: 46,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: false,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          icon: Icon(
                            Icons.shield_outlined,
                            size: 1,
                          ),
                          hintText: 'Community Guidelines:',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: false,
                          fillColor: Color(0xFF838383),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              //this is where host goes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //this contains our host drop down.
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 360,
                      height: 55,
                      //color: Color(0xFF838383),
                      padding: EdgeInsets.all(1),
                      // decoration: BoxDecoration(
                      //   color: Color(0xFF838383),
                      //   borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: TypeAheadField<User?>(
                        //Here we use <User> because that is what we are autocompleting for.
                        hideOnEmpty: true,
                        //TypeAheadField - A TextField that displays a list of suggestions as the user types.
                        //hideSuggestionsOnKeyboardHide: false,
                        direction: AxisDirection.up,
                        textFieldConfiguration: TextFieldConfiguration(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.search, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                            ),
                            hintText: 'Hosts: ',
                            hintStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            filled: true,
                            fillColor: Color(0xFF838383),
                            contentPadding: EdgeInsets.all(10),
                          ),
                        ),
                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                          color: Color(0xFF838383),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suggestionsCallback: UserData
                            .getSuggestions, //we get suggestions from UserData
                        itemBuilder: (context, User? suggestion) {
                          final user = suggestion!;

                          return ListTile(
                            leading: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(user.imageUrl),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            title: Text(user.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
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
                          final user = suggestion!;

                          setState(() {
                            communityHostName = user.name;
                            communityExistsHost = true;
                          });
                          //the suggestion that we selected is stored in user variable.

                          //Container(height: 20, width: 20, Text(name));

                          //this is the part where we say what we want to do in the selection... aka we need to put it in a container.

                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => UserDetailPage(user: user)
                        }
                        /*
                          Container(height:20, width:20,
                          Text(suggestion.name;)*/

                        //this is the part where we say what we want to do in the selection... aka we need to put it in a container.
                        /*
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserDetailPage(user: user)
                        )
                        );*/
                        ,
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                  visible: communityExistsHost,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                            side: BorderSide(color: Color(0xff4589FF)))),
                    onPressed: () {
                      setState(() {
                        communityExistsHost = false;
                        communityHostName = '';
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(communityHostName),
                        Icon(
                          Icons.close,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  )),
              SizedBox(height: 5),
              //SizedBox(height: 10),

              Row(
                //Description
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 360,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Color(0xFF838383),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: false,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          hintText: 'Description:',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: false,
                          fillColor: Color(0xFF838383),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                      flex: 1, // default
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF838383),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        width: 360,
                        height: 46,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Padding(
                              padding: EdgeInsets.only(left: 1.0),
                              child: Text('Select Category:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(12.0),
                            dropdownColor: Color(0xFF838383),
                            style: const TextStyle(
                                color: Colors.white, //<-- SEE HERE
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white, // <-- SEE HERE
                            ),
                            value: _comSelected,
                            onChanged: (newValue) {
                              setState(() {
                                _comSelected = newValue;
                              });
                            },
                            items: _comunJson.map(
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
                      ) // required field
                      ),
                ],
              ),

              SizedBox(height: 20),

              //Post Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: 250.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          widget.comPanelController.close();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff4589FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0))),
                        child: const Text(
                          'Post',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

  void togglePanel() => widget.comPanelController
          .isPanelOpen //this is working, but you have to click exactly on the skinny gray line for it to work... i wonder how this would translate to using the app on a real phone, hopefully would not be a problem.
      ? widget.comPanelController.close()
      : widget.comPanelController.open();
}

///////////////////////////////////////////////////////////////////////////////////
///Home Screen
///////////////////////////////////////////////////////////////////////////////////

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _eventSelected;
  List<Map> _eventJson = [
    {'id': '1', 'name': 'All'},
    {'id': '2', 'name': 'Friends'},
    {'id': '3', 'name': 'Communities'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: const Color(0xffC4DFCB),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/man_run_2.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF3F3F3F),
                borderRadius: BorderRadius.circular(12.0),
              ),
              width: 150,
              height: 50,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text(
                      'All',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(12.0),
                  dropdownColor: Color(0xFF3F3F3F),
                  style: const TextStyle(
                      color: Colors.white, //<-- SEE HERE
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white, // <-- SEE HERE
                  ),
                  value: _eventSelected,
                  onChanged: (newValue) {
                    setState(() {
                      _eventSelected = newValue;
                    });
                  },
                  items: _eventJson.map(
                    (categoryItem) {
                      return DropdownMenuItem(
                        value: categoryItem['id'].toString(),
                        child: Row(
                          children: [
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
          Positioned(
            top: 10,
            left: 200,
            child: Container(
              height: 50,
              width: 200,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.purple,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.purple
                    ],
                    stops: [0.0, 0.1, 0.9, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UPEStory()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/home_screen_stories/theupe_story.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GirlStory()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/home_screen_stories/girl_story.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SobeStory()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/home_screen_stories/sobe_story.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/Rectangle 158.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/Rectangle 156.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/Rectangle 157.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 20,
            //flex: 1,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen2()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    height: 50,
                    width: 50,
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
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Sam Scott",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                //Container(width:20, height:20, color:Colors.blue)
                Container(
                  width: 73.0,
                  height: 25.0,
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
              ],
            ),
          ),
          Positioned(
            bottom: 110,
            left: 20,
            //flex: 1,
            child: Row(
              children: [
                Text(
                  "Morning run",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 155,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    color: Color(0xffD7D9D7),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blue,
                        blurRadius: 3,
                      ),
                    ],
                    image: DecorationImage(
                      image:
                          AssetImage("assets/category_logos/sports_logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 40),
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/home_screen_user_1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        //alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/home_screen_user_2.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 95,
            left: 20,
            child: Text(
              "Running and breakfast tomorrow!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width, //color: Colors.red,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color(0xff4589FF),
                      Colors.white.withOpacity(0.0)
                    ]))),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            // ignore: prefer_const_literals_to_create_immutables
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(Icons.place_outlined, size: 20, color: Colors.white),
                Text(
                  "Tamiami Park, 7 AM",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////
///Profile
///////////////////////////////////////////////////////////////////////////////////

class ProfileScreen extends StatefulWidget {
  static String tag = 'profile-screen-1';
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File? image1;
  File? image2;

  void profileDatePicker(ctx) {
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
                            startDate = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(ctx, rootNavigator: true).pop(ctx),
                    },
                  )
                ],
              ),
            ));
  }

  var dropdownValue;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          left: true,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      //Profile Banner Image Picker
                      Positioned(
                        //flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            alignment: Alignment(.90, -.75),
                            height: 130,
                            width: 360,
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle,
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 210.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //White Circle around it
                      Positioned(
                        //flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ),

                      //Profile Picture Image Picker
                      Positioned(
                        //flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle,
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 129.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          //alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "Jane Smith",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF3F3F3F),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(308, 1, 0, 0),
                          child: Icon(
                            Icons.snapchat,
                            size: 25,
                            color: Color(0xFF3F3F3F),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(338, 0, 0, 0),
                          child: Icon(
                            Icons.facebook,
                            size: 25,
                            color: Color(0xFF3F3F3F),
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(240, 0, 0, 0),
                          //alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 51.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //2
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(260, 0, 0, 0),
                          //alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 52.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //3
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(280, 0, 0, 0),
                          //alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 53.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //gap here
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              //alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Foodie, gymrat, and\n"
                                "cinema enthusiast.",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF3F3F3F),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 80),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 100.0,
                              height: 25.0,
                              //padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff4589FF),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0))),
                                  child: const Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 340,
                        height: 2,
                        decoration: BoxDecoration(
                            color: Color(0xFF3F3F3F),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 46,
                    width: 342,
                    child: ElevatedButton(
                      onPressed: () => profileDatePicker(this.context),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(255, 70, 68, 68),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Text(
                        startDate != null
                            ? DateFormat.EEEE().format(startDate) +
                                ', ' +
                                DateFormat.MMM().format(startDate) +
                                '. ' +
                                DateFormat.d().format(startDate)
                            : 'No Date!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: false,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          //alignment: Alignment.center,
                          height: 154,
                          width: 342,
                          decoration: BoxDecoration(
                            color: Color(0xFF838383),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(153.5, 6.25, 0, 0),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),

                      //line
                      Positioned(
                        top: 45,
                        child: Container(
                          width: 342,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 48, 46, 46),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      ////////////////////////////////////////////////////////////////////
                      ///date stuff
                      ///////////////////////////////////////////////////////////////

                      //date-3
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 285, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: -3))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //date-2
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 190, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: -2))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //date-1
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 95, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: -1))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //date
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: 0))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //
                      //date +1
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(95, 10, 0, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: 1))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //date + 2
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(190, 10, 0, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: 2))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //date +3
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(285, 10, 0, 0),
                          height: 154,
                          width: 342,
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat.d()
                                .format(startDate.add(Duration(days: 3))),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: false,
                          ),
                        ),
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////

                      //blue boxes start
                      Positioned(
                        child: Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(12, 50, 0, 0),
                          child: Container(
                            height: 46,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Color(0xff4589FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Volleyball Game",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 26,
                                ),
                                Container(
                                  width: 2,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "WRC @ MMC",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(12, 100, 0, 0),
                          child: Container(
                            height: 46,
                            width: 320,
                            decoration: BoxDecoration(
                              color: Color(0xff4589FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Smash Bros To...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 21,
                                ),
                                Container(
                                  width: 2,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "PCA 150 @ M..",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //height:342,
                  width: 348,
                  child: Column(
                    children: [
                      Row(
                        //row with text "Recent Posts"
                        children: const [
                          //Padding(
                          //padding: EdgeInsets.only(left: 24),
                          Text(
                            " Recent Posts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 63, 63, 63),
                              fontSize: 20,
                            ),
                          ),
                          //),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        //first row of images.
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              //margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  //fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/profile_post_images/row_1_col_1.png"),
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(width:10),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  //fit:BoxFit.fitWidth,
                                  image: AssetImage(
                                    "assets/profile_post_images/row_1_col_2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_1_col_3.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        //second row of images.
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/profile_post_images/row_2_col_1.png"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_2_col_2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_2_col_3.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 55),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
///Profil2
////?/////////////////////////////////////////////////////////////////////////////////////
class ProfileScreen2 extends StatefulWidget {
  static String tag = 'profile-screen-2';
  @override
  ProfileScreenState2 createState() => ProfileScreenState2();
}

class ProfileScreenState2 extends State<ProfileScreen2> {
  void profileDatePicker(ctx) {
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
                            startDate = val;
                          });
                        }),
                  ),
                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => {
                      Navigator.of(ctx, rootNavigator: true).pop(ctx),
                    },
                  )
                ],
              ),
            ));
  }

  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          left: true,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      //Profile Banner Image Picker
                      Positioned(
                        //flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            alignment: Alignment(.90, -.75),
                            height: 130,
                            width: 360,
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle,
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 210.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //White Circle around it
                      Positioned(
                        //flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ),

                      //Profile Picture Image Picker
                      Positioned(
                        //flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle,
                              color: Color(0xffD7D9D7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 129.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          //alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "Sam Scott",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF3F3F3F),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(308, 1, 0, 0),
                          child: Icon(
                            Icons.snapchat,
                            size: 25,
                            color: Color(0xFF3F3F3F),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(338, 0, 0, 0),
                          child: Icon(
                            Icons.facebook,
                            size: 25,
                            color: Color(0xFF3F3F3F),
                          ),
                        ),
                      ),

                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(240, 0, 0, 0),
                          //alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 51.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //2
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(260, 0, 0, 0),
                          //alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 52.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //3
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(280, 0, 0, 0),
                          //alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 53.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //gap here
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              //alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Hi, I am Sam!\n"
                                "I love outdoor runs!",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFF3F3F3F),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 80),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 100.0,
                              height: 25.0,
                              //padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff4589FF),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9.0))),
                                  child: const Text(
                                    'Follow',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    softWrap: false,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 340,
                        height: 2,
                        decoration: BoxDecoration(
                            color: Color(0xFF838383),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  //height:342,
                  width: 348,
                  child: Column(
                    children: [
                      Row(
                        //row with text "Recent Posts"
                        children: const [
                          //Padding(
                          //padding: EdgeInsets.only(left: 24),
                          Text(
                            " Pinned",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 63, 63, 63),
                              fontSize: 20,
                            ),
                          ),
                          //),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        //first row of images.
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              //margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  //fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/profile_post_images/row_0_col_0.png"),
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(width:10),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  //fit:BoxFit.fitWidth,
                                  image: AssetImage(
                                    "assets/profile_post_images/row_0_col_1.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_0_col_2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //height:342,
                  width: 348,
                  child: Column(
                    children: [
                      Row(
                        //row with text "Recent Posts"
                        children: const [
                          //Padding(
                          //padding: EdgeInsets.only(left: 24),
                          Text(
                            " Recent Posts",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 63, 63, 63),
                              fontSize: 20,
                            ),
                          ),
                          //),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        //first row of images.
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              //margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  //fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/profile_post_images/row_1_col_1.png"),
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(width:10),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  //fit:BoxFit.fitWidth,
                                  image: AssetImage(
                                    "assets/profile_post_images/row_1_col_2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_1_col_3.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        //second row of images.
                        children: [
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/profile_post_images/row_2_col_1.png"),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_2_col_2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20), //rounded corners of container
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/profile_post_images/row_2_col_3.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 55),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
///StoryScreenUPE LOGO
////?/////////////////////////////////////////////////////////////////////////////////////
class UPEStory extends StatefulWidget {
  static String tag = 'upe-story';
  @override
  UPEStoryState createState() => UPEStoryState();
}

class UPEStoryState extends State<UPEStory> {
  
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/concert_story.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            //flex: 1,
            child: Row(
              children: [
                
                  GestureDetector(
                    
                    
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        color: Color(0xffD7D9D7),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        image: DecorationImage(
                          image: AssetImage("assets/home_screen_stories/theupe_story.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                
                SizedBox(
                  width: 15,
                ),
                Text(
                  "UPE",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 170,
                ),
                //Container(width:20, height:20, color:Colors.blue)
                
                SizedBox(width: 15),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                  size: 24.0,
                ),
                SizedBox(width: 15),
               Icon(Icons.close, color: Color.fromARGB(255, 255, 255, 255), size: 34.0),
                SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width, //color: Colors.red,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color(0xff4589FF),
                      Colors.white.withOpacity(0.0)
                    ]))),
          ),
          Positioned(
            top: 100,
            left: 20,
            // ignore: prefer_const_literals_to_create_immutables
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(Icons.place_outlined, size: 20, color: Colors.white),
                Text(
                  "Tamiami Park, 7 AM",
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
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
///StoryScreenGirlStor
////?/////////////////////////////////////////////////////////////////////////////////////
class GirlStory extends StatefulWidget {
  static String tag = 'girl-story';
  @override
  GirlStoryState createState() => GirlStoryState();
}

class GirlStoryState extends State<GirlStory> {
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home_screen_stories/tua.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            //flex: 1,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen2()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      color: Color(0xffD7D9D7),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                        image: AssetImage("assets/home_screen_stories/girl_story.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 15,
                ),
                Text(
                  "Sandy James",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                //Container(width:20, height:20, color:Colors.blue)

                SizedBox(width: 15),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                  size: 24.0,
                ),
                SizedBox(width: 15),
                Icon(Icons.close,
                    color: Color.fromARGB(255, 255, 255, 255), size: 34.0),
                SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width, //color: Colors.red,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color(0xff4589FF),
                      Colors.white.withOpacity(0.0)
                    ]))),
          ),
          Positioned(
            top: 100,
            left: 20,
            // ignore: prefer_const_literals_to_create_immutables
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(Icons.place_outlined, size: 20, color: Colors.white),
                Text(
                  "Hard Rock Stadium, 8 PM",
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
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////
///StoryScreenSobeStory
////?/////////////////////////////////////////////////////////////////////////////////////
class SobeStory extends StatefulWidget {
  static String tag = 'sobe-story';
  @override
  SobeStoryState createState() => SobeStoryState();
}

class SobeStoryState extends State<SobeStory> {
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/home_screen_stories/sobe.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            //flex: 1,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen2()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      color: Color(0xffD7D9D7),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/home_screen_stories/sobe_story.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 15,
                ),
                Text(
                  "SOBE WFF",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(255, 119, 117, 117),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                //Container(width:20, height:20, color:Colors.blue)

                SizedBox(width: 15),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red,
                  size: 24.0,
                ),
                SizedBox(width: 15),
                Icon(Icons.close,
                    color: Color.fromARGB(255, 255, 255, 255), size: 34.0),
                SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width, //color: Colors.red,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color(0xff4589FF),
                      Colors.white.withOpacity(0.0)
                    ]))),
          ),
          Positioned(
            top: 100,
            left: 20,
            // ignore: prefer_const_literals_to_create_immutables
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(Icons.place_outlined, size: 20, color: Colors.white),
                Text(
                  "Miami Beach, 12 PM",
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
        ],
      ),
    );
  }
}
