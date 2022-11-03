import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/event_screen.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/HomePage.dart';
import 'package:flutter_application/interest_screen_1.dart';
import 'package:flutter_application/interest_screen_2.dart';
import 'loginPage.dart';
import 'registerPage.dart';
import 'package:auth_service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    // HomePage.tag: (context) => HomePage(),
    RegisterPage.tag: (context) => RegisterPage(),
    InterestScreen1.tag: (context) => InterestScreen1(),
    InterestScreen2.tag: (context) => InterestScreen2(),
    HomePage.tag: (context) => HomePage(),
    EventScreen.tag: (context) => EventScreen()
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MaterialApp(
            title: 'Login',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              fontFamily: 'Nunito',
            ),
            home:
                EventScreen(), //LoginPage(), - replace this when done testing interest screens!
            routes: routes,
          )),
    );
  }
}
