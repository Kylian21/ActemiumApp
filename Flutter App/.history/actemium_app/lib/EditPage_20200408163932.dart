import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class EditPage extends StatelessWidget {
  String name;
  String deviceID;
  EditPage({Key key, @required this.name, @required this.deviceID})
      : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 10,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Paramètre Bluetooth",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width*0.7,
              decoration: BoxDecoration(
                border: Border.all(width: 2)
              ), 
              child: Text("Module Bluetooth :")),
          Text(deviceID),
          Text("Nom associé :"),
          Container(
            child: TextField(
              decoration:
                  InputDecoration(hintText: "Entrez le nom de votre module"),
            ),
          ),
          Text("Mot de passe"),
          TextField(
            decoration: InputDecoration(hintText: "Entrez le mot de passe"),
          ),
          Text("Seuil d'intensité de bâchage"),
          TextField(),
          Text("Seuil d'intensité de débâchage"),
          TextField(),
          Text("Vitesse limite d'alerte"),
          TextField(),
        ],
      ),
    );
  }
}
