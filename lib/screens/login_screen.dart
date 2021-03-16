import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/components/button_component.dart';
import 'package:insta_clone/components/textformfield.dart';

class LoginScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mail;
  TextEditingController pass;

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(60.0),
                child: ButtonC("Sign in",signIn()),),
             ButtonC("Sign Up", signUp()) 
              
            ],

            )
          ],
        ),
      ),
    );
  }

  Function signIn() {}

  Function signUp() {}
}
