import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/community_screen.dart';
import 'package:flutter_application/event_screen.dart';
import 'package:flutter_application/event_thread_screen.dart';
import 'package:flutter_application/firebase_options.dart';
import 'package:flutter_application/HomePage.dart';
import 'package:flutter_application/interest_screen_1.dart';
import 'package:flutter_application/interest_screen_2.dart';
import 'package:flutter_application/pick_hosts_tester.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';
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
    EventThreadScreen.tag: (context) => EventThreadScreen(),
    //EventScreen.tag: (context) => EventScreen(),
    // CommunityScreen.tag: (context) => CommunityScreen(),
    //LocalTypeAheadPage.tag: (context) => LocalTypeAheadPage()
  };

  @override
  Widget build(BuildContext context) {
    /*return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());*/
    //},
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
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
            home: EventThreadScreen(), //EventScreen(), //for Jose
            routes: routes,
          )),
    );
    //);
  }
}
