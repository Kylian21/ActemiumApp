
import 'package:actemium_app_user/lib/ConfigSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordDialogue extends StatefulWidget {
  PasswordDialogue({Key key}) : super(key: key);
  @override
  PasswordDialogueState createState() => PasswordDialogueState();
}

class PasswordDialogueState extends State<PasswordDialogue> {
  final TextEditingController _controller = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  RegExp pinCodeRegExp = RegExp(r'(^(?:\d{4}|\d{6})$)');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Mot de passe demandé",
        style: TextStyle(
            color: Colors.grey[800],
            fontSize: ConfigSize.blockSizeVertical * 4,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontFamily: 'Open Sans'),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _controller,
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[300])),
              errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: ConfigSize.blockSizeVertical * 2,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Open Sans'),
              labelText: "Entrez votre mot de passe",
              labelStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: ConfigSize.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Open Sans')),
          validator: (value) {
            if (value.isEmpty) {
              return 'Le mot de passe ne peut pas être nul';
            } else if (!pinCodeRegExp.hasMatch(value)) {
              return 'Erreur : 4 ou 6 chiffres';
            } else {
              return null;
            }
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              "Annuler",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: ConfigSize.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Open Sans'),
            )),
        FlatButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: Text(
              "Valider",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: ConfigSize.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Open Sans'),
            ))
      ],
    );
  }
}
