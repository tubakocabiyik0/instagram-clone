import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/screens/FirebaseIn%C4%B1t.dart';

class FindFriendsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateFindFriendsPage();
  }

}
class StateFindFriendsPage extends State<FindFriendsPage>{
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  List<String>mailList;
  List<String> imageList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:bodyMethod(),
      );
  }

  bodyMethod() {
    return FutureBuilder(builder: (context,AsyncSnapshot snapshot){
      return ListView.builder(itemBuilder: (context,index){

      });
    }) ;

  }
getAllUsers(){

}
}