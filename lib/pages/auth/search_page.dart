import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application/widgets/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<String> searches = [];
int lenght = searches.length;

class _SearchPageState extends State<SearchPage> {
  TextEditingController textfieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    child: TextField(
                      controller: textfieldController,
                      onSubmitted: ((value) {
                        setState(() {
                          searches.add(value);
                          lenght = searches.length;
                        });
                        textfieldController.clear();
                      }),
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          filled: true,
                          hintText: ("What are we looking for?"),
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: Color(0xFF838383),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Communities",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0,24, 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/home_screen_stories/theupe_story.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/home_screen_stories/girl_story.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/home_screen_stories/sobe_story.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/Rectangle 158.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/Rectangle 156.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/Rectangle 157.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/home_screen_stories/theupe_story.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/home_screen_stories/girl_story.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/home_screen_stories/sobe_story.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/Rectangle 158.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/Rectangle 156.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/Rectangle 157.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Divider(
              color: Color(0xFFD7D9D7),
              thickness: 5,
              
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Recent Searches",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: lenght,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                          flex: 10,
                          child: GestureDetector(
                            onTap: () {
                              textfieldController.text = searches[index];
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContextcontext) {
                                    return SimpleDialog(
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          child: Text('Copy To Clipboard'),
                                          onPressed: () async {
                                            await Clipboard.setData(
                                                ClipboardData(
                                                    text: searches[index]));
                                            nextScreen(context, SearchPage());
                                          },
                                        ),
                                        SimpleDialogOption(
                                          child:
                                              Text('Remove ${searches[index]}'),
                                          onPressed: () {
                                            setState(() {
                                              searches.remove(index);
                                              lenght = searches.length;
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SimpleDialogOption(
                                          child: Text('Remove All'),
                                          onPressed: () {
                                            setState(() {
                                              searches.clear();
                                              lenght = searches.length;
                                            });
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              searches[index],
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              icon: Icon(Icons.close),
                              color: Colors.black,
                              onPressed: (() {
                                setState(() {
                                  searches.removeAt(index);
                                  lenght = searches.length;
                                });
                              })))
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
