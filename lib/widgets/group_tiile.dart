import 'package:flutter/material.dart';
import 'package:flutter_application/pages/auth/chat_Page.dart';
import 'package:flutter_application/pages/auth/loginpage2.dart';
import 'package:flutter_application/widgets/widgets.dart';

class GroupTile extends StatefulWidget {
  final String username;
  final String groupID;
  final String groupname;
  const GroupTile(
      {Key? key,
      required this.groupID,
      required this.groupname,
      required this.username})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
                groupId: widget.groupID,
                groupName: widget.groupname,
                currentUsername: widget.username));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: Text(
              widget.groupname.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            widget.groupname,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Join the conversation as ${widget.username}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
