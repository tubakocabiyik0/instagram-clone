import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/screens/FirebaseIn%C4%B1t.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateProfilePage();
  }
}

class StateProfilePage extends State<ProfilePage> {
  PickedFile _pickedFile;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            child: _pickedFile == null
                ? Center(child: Text("Choose Photo"))
                : Image.file(File(_pickedFile.path)),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          RaisedButton(
              child: Text("Go Gallery"),
              color: Colors.lightBlue.shade200,
              onPressed: () {
                goGallery();
              }),
          RaisedButton(
              child: Text("Go Camera"),
              color: Colors.lightBlue.shade200,
              onPressed: () {
                goCamera();
              }),
        ]),
        RaisedButton(
            child: Text("Set profile page"),
            color: Colors.lightBlue.shade200,
            onPressed: () {
              setPP();
            }),
      ]),
    );
  }

  void goCamera() async {
    ImagePicker imagePicker = ImagePicker();
    var photo = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedFile = photo;
    });
  }

  void goGallery() async {
    ImagePicker imagePicker = ImagePicker();
    var photo = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = photo;
    });
  }

  void setPP() async {
    String uid = _firebaseAuth.currentUser.uid;
    StorageUploadTask storageUploadTask = _firebaseStorage
        .ref()
        .child("users")
        .child("images")
        .child(uid)
        .putFile(File(_pickedFile.path));
    String getUrl =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();

    DocumentReference documentReference = _firebaseFirestore
        .collection("users")
        .doc(uid)
        .collection("posts")
        .doc("ProfilePhoto");
     await documentReference.set({'Pimage:': getUrl});
  }
}
