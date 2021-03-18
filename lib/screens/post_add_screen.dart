import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatePostAdd();
  }
}

class StatePostAdd extends State<PostAdd> {
  var comment = TextEditingController();
  int s = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  PickedFile _pickedFile;
  var Uid;
  var Url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Textformfield(
              labelText: "Comment",
              obscureText: false,
              controller: comment,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
                child: Text(" Share Post"),
                color: Colors.lightBlue.shade200,
                onPressed: () {
                  sharePost();
                }),
          )
        ],
      ),
    );
  }

  void goGallery() async {
    ImagePicker imagePicker = ImagePicker();
    var photo = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = photo;
    });
    Uid = await _auth.currentUser.uid;

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("Users")
        .child("images")
        .child(Uid);
    StorageUploadTask storageUploadTask =
        await ref.putFile(File(_pickedFile.path));
    Url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    debugPrint(Url);
  }

  void goCamera() async {
    ImagePicker imagePicker = ImagePicker();
    var photo = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _pickedFile = photo;
    });
    Uid = _auth.currentUser.uid;

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("user")
        .child("images")
        .child("tu.png");
    StorageUploadTask storageUploadTask =
        await ref.putFile(File(_pickedFile.path));
    Url = await (await storageUploadTask.onComplete).ref.getDownloadURL();
  }

  void sharePost() async {
    DocumentReference documentReference = _firebaseFirestore
        .collection("users")
        .doc(Uid)
        .collection("posts")
        .doc("Posts $s");
    String comm = comment.text;
    await documentReference.set({'comment': comm, 'image': Url});
    s++;
  }
}
