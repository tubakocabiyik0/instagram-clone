import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/button_component.dart';
import 'package:insta_clone/components/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_clone/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {


  var mail = TextEditingController();
  var pass = TextEditingController();
  String Uid;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text("Login"),
        leading: Icon(Icons.person),
      ),
      body: loginbody(),
    );
  }

  loginbody() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.blue.shade300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 130, right: 8, left: 8),
              child: Textformfield(
                labelText: "mail",
                obscureText: false,
                controller: mail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Textformfield(
                labelText: "password",
                obscureText: true,
                controller: pass,
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: RaisedButton(
                      onPressed: () {
                        signIn();
                      },
                      child: Text(
                        "sign in",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      color: Colors.white,
                    )),
                RaisedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text(
                    "sign up",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  color: Colors.white,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    String email = mail.text;
    String passW = pass.text;

    await _auth.signInWithEmailAndPassword(email: email, password: passW);

      Navigator.pushReplacementNamed(context, 'home');
    }


  Future signUp() async {
    String email = mail.text;
    String passW = pass.text;

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: passW);

    await _auth.signOut();
    Navigator.pushReplacementNamed(context, 'home');
    //debugPrint("please.........................00");
    //

    Uid = (userCredential.user.uid);
    DocumentReference documentReferenceall=firebaseFirestore.collection("users").doc(Uid).collection("posts").doc("comments");
    documentReferenceall.set({'uid':Uid});


}
}