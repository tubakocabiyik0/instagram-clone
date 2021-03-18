import 'package:flutter/material.dart';
import 'package:insta_clone/screens/FirebaseIn%C4%B1t.dart';
import 'package:insta_clone/screens/home_screen.dart';
import 'package:insta_clone/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'FırebaseInit',
      routes: {
        'FırebaseInit':(context) =>App(),
        'login': (context) => LoginScreen(),
        'home':(context)=>HomePage(),
      },
    );
  }
}
