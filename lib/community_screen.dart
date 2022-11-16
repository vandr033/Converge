import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/HomePage.dart';
import 'package:flutter_application/event_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'data/user_data.dart';

const List<String> screens = ['Create Community', 'Create Event'];
String? chosenScreen = 'Create Community';

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
  /*
  Drop down 
  */
  String? _selected;

  List<Map> _myJson = [
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

  /*
  Image Picker
  */
  File? image1;
  File? image2;

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
                Expanded(
                  flex: 6,// default
                  child: Container(// required field                  
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0XFFD7D9D7),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  width: 226,
                  height: 46,

                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(12.0),
                    dropdownColor: Color(0XFFD7D9D7),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EventScreen()));
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
                )
                ),
                

                Expanded(
         flex: 0,// default
         child: Container(
                  width: 20,
                ),// required field
                ),
                

                Expanded(
         flex: 4,// default
         child: Container(
                  width: 114,
                  height: 46,
                  child: TextField(
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
                        ) ,
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
                        ),
                  ),
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
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    elevation: 8.0,
                    child: Container(
                        alignment: Alignment(.90, -.75),
                        height: 110,
                        width: 360,
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
                      pickImage1();
                    },
                  ),
                ),

                //white buffer between the circle image and rectangle immage
                Expanded(
                  flex: 1,
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
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        height: 75,
                        width: 75,
                        decoration: image2 != null
                            ? BoxDecoration(
                                color: Color(0xffD7D9D7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                image: DecorationImage(
                                    image: FileImage(image2!), fit: BoxFit.fill))
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffD7D9D7),
                              ),
                        child: image2 != null
                            ? Icon(null)
                            : Icon(Icons.upload_rounded, color: Colors.white)),
                  ),
                ),
              ],
              //),
            ),

            SizedBox(height: 0),

            Stack(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 360,
                    height: 46,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                      color: Color(0xffD7D9D7),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                    child: Icon(
                      Icons.shield_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                    child: Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 360,
                    height: 46,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.shield_outlined,
                            size: 1,
                          ),
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
                ),
              ],
            ),

            SizedBox(height: 10),

            //this is where host goes
            Row(
              //this contains our host drop down.
              children: [
                Expanded(
                  child: Container(
                    //color: Color(0xffD7D9D7),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffD7D9D7),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
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

            SizedBox(height: 10),
            
            Row(
              //example
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
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
                ),
              ],
            ),

            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Expanded(
                flex: 1,
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
                              hint: Text('Select Category'),
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
            ),

            SizedBox(height: 20),

            //enter post button here //used next button as template CHANGE THIS!!!!!!!!!!!!!!!!
            Row(
              //row 9 - "next" button
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 250.0,
                    height: 40.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 0, 0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                    
                    SizedBox(width: 20),

                //The actual formatting of the 'Next' button and everything we do for it
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 250.0,
                    height: 40.0,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
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
                  ),
                ),
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
