import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:insta_clone/screens/home_screen.dart';
import 'package:insta_clone/screens/login_screen.dart';


class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  bool isTrue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(firebaseAuth.currentUser!=null){
    setState(() {
      isTrue=true;
    });

    }else{
      setState(() {
        isTrue=false;
      });

    }
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

  }


        @override
        Widget build(BuildContext context)
    {
      return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text("error");
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
           if(isTrue!=null){
             return HomePage();
           }else{
             return LoginScreen();
           }
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator(),);
        },
      );
    }
  }