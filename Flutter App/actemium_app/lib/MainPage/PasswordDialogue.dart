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
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
            errorText: _validate ? "" : "Mot de passe invalide",
            labelText: "Entrez votre mot de passe"),
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
