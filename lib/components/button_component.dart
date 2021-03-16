import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonC extends StatelessWidget {
  String text;
  Function clicked;

  ButtonC(this.text, this.clicked);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(

      onPressed: clicked,
      color:Colors.white,
      child: Text(text,style: TextStyle( fontSize: 20),),
    );
  }
}
