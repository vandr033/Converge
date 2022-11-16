import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application/helper/helper_function.dart';
import 'package:flutter_application/services/firestore_services.dart';

class AuthService {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  //login
  Future loginWemailAndPasswword(String email, String password) async {
    try {
      User user = (await firebaseauth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //register
  Future registerUserWithEmailandPassword(
      String username, String email, String Password) async {
    try {
      User user = (await firebaseauth.createUserWithEmailAndPassword(
              email: email, password: Password))
          .user!;
      if (user != null) {
        //call db service to update user data
        await FirestoreServices(uid: user.uid).savingUserData(username, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  //signout

  Future signout() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmail('');
      await HelperFunctions.saveUserNameInStatus('');
      await firebaseauth.signOut();
    } catch (e) {
      return null;
    }
  }
}
