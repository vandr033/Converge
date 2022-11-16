import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/helper/helper_function.dart';
import 'package:flutter_application/services/firestore_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String username = "";
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserIDandName();
  }

  getCurrentUserIDandName() async {
    await HelperFunctions.getUsername().then((value) {
      setState(() {
        username = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[700],
        title: Text(
          "Search",
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              initiateSearchMethod();
            },
            child: Container(
              color: Colors.blueGrey[700],
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: ("Search Groups")),
                )),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[700]!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(9)),
                  child: Icon(Icons.search),
                )
              ]),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey[700],
                  ),
                )
              : groupList()
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await FirestoreServices()
          .searchGroupByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          _isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(username, searchSnapshot!.docs[index]['groupID'],
                  username, searchSnapshot!.docs[index]['groupName']);
            })
        : Container();
  }

  Widget groupTile(
      String username, String groupId, String groupname, String admin) {
    return Text('Hello');
  }
}
