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
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Container(
                width: MediaQuery.of(context).size.width*0.90,
                decoration: BoxDecoration(
                  border: Border.all(width: 2)
                ), 
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("MODULE BLUETOOTH :",style: TextStyle(fontSize: 20),),
                )),
          ),
          Text(deviceID),
          Text("Nom associé :"),
          Container(
            child: TextField(
              decoration:
                  InputDecoration(
                    labelText: "NOM module",
                    border: OutlineInputBorder()),
            ),
          ),
          TextField(
            decoration: InputDecoration(hintText: "Mot de passe"),
          ),
          Text("SEUIL D'INTENSITE"),
          Text("bâchage"),
          TextField(),
          Text("débâchage"),
          TextField(),
          Text("Vitesse limite d'alerte"),
          TextField(),
        ],
      ),
    );
  }
}
