import 'package:flutter/material.dart';
import 'package:flutter_application/pages/chat/chat_Page.dart';
import 'package:flutter_application/widgets/widgets.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xFF838383),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Group Chats',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child:
                              Image.asset('assets/chatpage/Rectangle 130.png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FIU Soccer • 2h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Prepping for a 5k next week so this is perfect!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child: Image.asset(
                              'assets/chatpage/Rectangle 130 (1).png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Miami Knights • 3h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'I might shoot for a 10k tomorow',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child: Image.asset(
                              'assets/chatpage/Rectangle 130 (2).png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wynwood • Yesterday',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Do yall want a table at Sugar?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child: Image.asset(
                              'assets/chatpage/Rectangle 130 (3).png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Taco Tuesday • 10m',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Bought some fire tacos yesterday!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child: Image.asset(
                              'assets/chatpage/Rectangle 130 (4).png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MAN4720 Study Group • 2h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'That exam was crazy hard',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child: Image.asset(
                              'assets/chatpage/Rectangle 130 (5).png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sparkdev • 2h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Demo Day is going to be lit!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => nextScreen(context, ChatPage()),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF838383),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 60,
                          child: Image.asset(
                              'assets/chatpage/Rectangle 130 (6).png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'COP 4338• 2h',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Im so glad this class is over',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        flex: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
