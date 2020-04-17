import 'package:actemium_app/MainPage/MainPageProvider.dart';
import 'package:actemium_app/commandsPage/ScaleTransition.dart';
import 'package:actemium_app/commandsPage/commandsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordDialogue extends StatefulWidget {
  final String text;
  PasswordDialogue({
    this.text
  });
  @override
  _PasswordDialogueState createState() => _PasswordDialogueState();
}

class _PasswordDialogueState extends State<PasswordDialogue> {
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

  Widget build(BuildContext context) {
    final provider = Provider.of<MainPageProvider>(context);
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
              Navigator.pop(context);
            },
            child: Text("Annuler")),
        FlatButton(
            onPressed: () {
              if (_controller.text == "1234") {
                provider.resetProvider();
                Navigator.push(
                    context,
                    ScaleRoute(
                        page: CommandsPage(deviceName: this.widget.text)));
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
