import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordDialogue extends StatefulWidget {
  PasswordDialogue({Key key}) :super(key:key);
  @override
  PasswordDialogueState createState() => PasswordDialogueState();
}

class PasswordDialogueState extends State<PasswordDialogue> {
  final TextEditingController _controller = new TextEditingController();
  bool _validate = true;
  RegExp pinCodeRegExp = RegExp(r'^(?:\d{4}|\d{6})$');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  get validate => _validate;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Mot de passe demandé"),
      content: Form(
          child: TextFormField(
            keyboardType: TextInputType.number,
          controller: _controller,
          decoration: InputDecoration(
              errorText: _validate ? "" : "Mot de passe invalide",
              labelText: "Entrez votre mot de passe"),
          validator: (value){
            if(!pinCodeRegExp.hasMatch(value)){
              return 'Le mot de passe n\'est pas sous forme de pin à 4 ou 6 chiffres';
            }
            else{
              return '';
            }
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context,false);
            },
            child: Text("Annuler")),
        FlatButton(
            onPressed: () {
              if (_controller.text == "1234") {
                _validate=true;
                Navigator.pop(context,true);
              } else {
                setState(() {
                  _validate = false;
                });
              }
            },
            child: Text("Valider"))
      ],
    );
  }
}
