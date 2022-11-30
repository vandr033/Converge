import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/event_screen.dart';

class FirestoreServices {
  final String? uid;
  FirestoreServices({this.uid});

  //reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');
  // update user model

  Future savingUserData(String username, String email) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "email": email,
      "groups": [],
      "chats": [],
      "uid": uid,
    });
  }

  //getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  //get user groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //create a group
  Future createGroup(String username, String uid, groupname) async {
    DocumentReference groupdocumentReference = await groupCollection.add({
      "groupName": groupname,
      "groupIcon": "",
      "admin": "${uid}_$username",
      "members": [],
      "groupID": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //update the member to the creator
    await groupdocumentReference.update({
      "members": FieldValue.arrayUnion(["${uid}_$username"]),
      "groupID": groupdocumentReference.id,
    });
    DocumentReference userDocumentReference = await userCollection.doc(uid);
    return await userDocumentReference.update({
      "groups":
          FieldValue.arrayUnion(["${groupdocumentReference.id}_$groupname"])
    });
  }

  //getGroupChats
  getChats(String groupID) async {
    return groupCollection.doc(groupID).collection("messages").snapshots();
  }

  Future getGroupAdmin(String groupID) async {
    DocumentReference d = groupCollection.doc(groupID);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }

  //get group members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  //search by groupname
  searchGroupByName(String groupName) {
    return groupCollection.where("groupname", isEqualTo: groupName);
  }

  //search by username
  Future searchUsername(String username) async {
    QuerySnapshot snapshot =
        await userCollection.where("username", isEqualTo: username).get();
    return snapshot;
  }
}
