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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
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
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "MODULE BLUETOOTH :",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(border: Border.all(width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("$deviceID", style: TextStyle(fontSize: 20)),
                )),
            Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: TextField(
                    cursorColor: Colors.blueGrey,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                          borderSide: BorderSide(width: 2, color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                      ),
                      labelText: "NOM MODULE",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: TextField(
                    cursorColor: Colors.blueGrey,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                          borderSide: BorderSide(width: 2, color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                      ),
                      labelText: "MOT DE PASSE",
                      labelStyle: TextStyle(color: Colors.blueGrey),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "SEUIL D'INTENSITE :",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        labelText: "BACHAGE",
                        labelStyle: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blueGrey,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        labelText: "DEBACHAGE",
                        labelStyle: TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                  cursorColor: Colors.blueGrey,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                        borderSide: BorderSide(width: 2, color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                    ),
                    labelText: "SENSIBILITE D'ALERTE",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
