import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'dart:convert';
import 'dart:math';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

final user2 = const types.User(id: '12345678910');
final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
final m1 = types.TextMessage(
  author: user2,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Hey, how are you?',
);
final m2 = types.TextMessage(
  author: _user,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Pretty Good And You?',
);
final m3 = types.TextMessage(
  author: user2,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Doing Okay, Are you going to Sahils Party tommorow?',
);
final m4 = types.TextMessage(
  author: _user,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Nah Its going to be lame',
);
final m5 = types.TextMessage(
  author: user2,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Yeah I agree, he stinks!',
);
final m6 = types.TextMessage(
  author: user2,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Are you going to UPEs Demo Day on Friday?',
);
final m7 = types.TextMessage(
  author: _user,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Yeah for sure and You?',
);
final m8 = types.TextMessage(
  author: user2,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Ofc, I heard its going to be lit',
);
final m9 = types.TextMessage(
  author: _user,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Yeah Im exicted about the mobile dev teams project',
);
final m10 = types.TextMessage(
  author: user2,
  createdAt: DateTime.now().microsecondsSinceEpoch,
  id: randomString(),
  text: 'Yeah it looks so good',
);

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [
    m10,
    m9,
    m8,
    m7,
    m6,
    m5,
    m4,
    m3,
    m2,
    m1,
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
      );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }
}
