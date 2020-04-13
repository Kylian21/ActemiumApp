import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditTextfield extends StatelessWidget {
  final String text;

  EditTextfield({Key key, this.text}) : super(key: key);

  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.zero),
            borderSide: BorderSide(width: 2, color: Colors.black)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black),
        ),
        labelText: this.text,
        labelStyle: TextStyle(color: Colors.blueGrey),
      ),
    );
  }
}
