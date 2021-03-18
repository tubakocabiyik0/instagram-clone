import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/screens/post_add_screen.dart';
import 'package:insta_clone/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
// This widget is the root of your application.

}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text("Instagram Clone"),
      ),
      body: homeBody(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.blue,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index=index;

          });
        },
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos_rounded),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "You",
          ),
        ],
      ),
    );
  }

  homeBody() {
    if(_index==0){
      return homePage();
      }
    if(_index==2){
      return PostAdd();
    }
    if(_index==3){
      return ProfilePage();
    }


  }

  homePage() {
return RaisedButton(
  child: Text("sign out"),
  onPressed: () async{
    await _firebaseAuth.signOut();
    Navigator.of(context).pushReplacementNamed('login');
  }
  ,
);
  }
}
