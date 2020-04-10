import 'package:actemium_app/TextfieldWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class EditPage extends StatelessWidget {
  final String name;
  final String deviceID;

  EditPage({Key key, @required this.name, @required this.deviceID})
      : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(245, 245, 230, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 245, 230, 1),
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 2),
                    left: BorderSide(width: 2),
                    right: BorderSide(width: 2),
                    bottom: BorderSide(width: 1),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "MODULE BLUETOOTH :",
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
            ),
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1),
                  left: BorderSide(width: 2),
                  right: BorderSide(width: 2),
                  bottom: BorderSide(width: 2),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("$deviceID",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: MyTextfield(
                    text: "NOM MODULE",
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: MyTextfield(text: "MOT DE PASSE")),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 2),
                    right: BorderSide(width: 2),
                    left: BorderSide(width: 2),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "SEUIL D'INTENSITE :",
                      style: TextStyle(fontSize: 15),
                    ),
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                children: <Widget>[
                  Expanded(child: MyTextfield(text: "BACHAGE")),
                  Expanded(
                    child: MyTextfield(text: "DEBACHAGE"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: MyTextfield(text: "SENSIBILITE D'ALERTE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
