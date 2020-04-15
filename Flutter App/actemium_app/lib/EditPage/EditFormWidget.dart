import 'package:actemium_app/EditPage/MaskedTextInputFormatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditFormWidget extends StatelessWidget {
  final String text;
  GlobalKey formKey;
  int formKeyIndex;
  RegExp immatriculationRegExp = RegExp(
      "[A-HJ-NP-TV-Z]{2}[\s-]{0,1}[0-9]{3}[\s-]{0,1}[A-HJ-NP-TV-Z]{2}|[0-9]{2,4}[\s-]{0,1}[A-Z]{1,3}[\s-]{0,1}[0-9]{2}");

  EditFormWidget({Key key, this.text, this.formKey, this.formKeyIndex})
      : super(key: key);

  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        inputFormatters: formKeyIndex == 0
            ? <TextInputFormatter>[
                MaskedTextInputFormatter(mask: 'xx-xxx-xx', separator: '-')
              ]
            : <TextInputFormatter>[],
        validator: (value) {
          if (!immatriculationRegExp.hasMatch(value)) {
            return 'La plaque d\'immatriculation n\'est pas valide';
          } else
            return null;
        },
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
      ),
    );
  }
}
