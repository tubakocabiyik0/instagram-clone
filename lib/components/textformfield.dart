import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Textformfield extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;

  Textformfield({
    this.labelText,
    this.obscureText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      obscureText: obscureText,
      controller: controller,
    );
  }
}
