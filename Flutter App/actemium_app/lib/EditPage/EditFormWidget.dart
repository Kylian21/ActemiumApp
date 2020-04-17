import 'package:actemium_app/EditPage/MaskedTextInputFormatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class EditFormWidget extends StatefulWidget{
  final String text;
  final GlobalKey<FormState> formKey;
  final int formKeyIndex;
   EditFormWidget({
     Key key, this.text, this.formKey, this.formKeyIndex})
      : super(key: key);

  @override
  EditFormWidgetState createState() {
    return EditFormWidgetState();
  }
}

class EditFormWidgetState extends State<EditFormWidget> {
  RegExp immatriculationRegExp = RegExp(
      '[A-HJ-NP-TV-Z]{2}[\s-]{0,1}[0-9]{3}[\s-]{0,1}[A-HJ-NP-TV-Z]{2}|[0-9]{2,4}[\s-]{0,1}[A-Z]{1,3}[\s-]{0,1}[0-9]{2}');
  RegExp pinCodeRegExp = RegExp(r'^(?:\d{4}|\d{6})$');

  Widget build(BuildContext context) {
    print(widget.formKey.toString());
    print(widget.formKeyIndex);
    return Form(
      key: widget.formKey,
      child: TextFormField(
        keyboardType: widget.formKeyIndex == 0
            ? TextInputType.text
            : TextInputType.number,
        textCapitalization: widget.formKeyIndex == 0
            ? TextCapitalization.characters
            : TextCapitalization.none,
        inputFormatters: widget.formKeyIndex == 0
            ? <TextInputFormatter>[
                MaskedTextInputFormatter(mask: 'xx-xxx-xx', separator: '-')
              ]
            : <TextInputFormatter>[],
        validator: (value) {
          if (widget.formKeyIndex == 0) {
            print("oui");
            if (!immatriculationRegExp.hasMatch(value)) {
              return 'La plaque d\'immatriculation n\'est pas valide';
            } else
              return '';
          } else if (widget.formKeyIndex == 1) {
            if (!pinCodeRegExp.hasMatch(value)) {
              return 'Le mot de passe n\'est pas sous forme de pin à 4 ou 6 chiffres';
            }
          } else
            return '';
        },
        cursorColor: Colors.blueGrey,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.zero),
              borderSide: BorderSide(width: 2, color: Colors.black)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.black),
          ),
          labelText: widget.text,
          labelStyle: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
