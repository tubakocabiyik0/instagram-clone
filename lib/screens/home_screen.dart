import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> comments = new List<String>();
  List<String> images = new List<String>();

  int _index = 0;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            _index = index;
          });
        },
        items: const <BottomNavigationBarItem>[
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
    if (_index == 0) {
      return homePage();
    }

    if (_index == 2) {
      return PostAdd();
    }
    if (_index == 3) {
      return ProfilePage();
    }
  }

  homePage() {
    return FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(),
                );
              });
        });
  }

  getData() async {
    var uid = _firebaseAuth.currentUser.uid;
    List<String> listComment = new List<String>();
    List<String> listImage = new List<String>();
    for (int i = 0; i < 2; i++) {
      DocumentSnapshot documentSnapshot =
          await _firebaseFirestore.doc("/users/$uid/posts/Posts $i").get();
      if (documentSnapshot.exists) {
        String comment = documentSnapshot.data()['comment'];
        listComment.add(comment);
        comments = listComment;
        String image = documentSnapshot.data()['image'];
        listImage.add(image);
        images = listImage;
      } else {
        debugPrint("error");
      }
    }
  }
}
