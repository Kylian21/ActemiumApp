import 'dart:async';
import 'package:actemium_app/EditPage.dart';
import 'package:actemium_app/IconCommandePage.dart';
import 'package:actemium_app/MainPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:actemium_app/commandsPageProvider.dart';

class CommandsPage extends StatelessWidget {
  //final BluetoothDevice device;
  final String deviceName;

  CommandsPage({Key key, @required this.deviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CommandsPageProvider(),
        child: Consumer<CommandsPageProvider>(builder: (context, provider, _) {
          return SafeArea(
              child: Material(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 11,
                  width: MediaQuery.of(context).size.width*0.7,
                  child: AppBar(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(10)),
                        ),
                    backgroundColor: Colors.white,
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(
                      "$deviceName",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.scale(
                    scale: 2,
                    child: FloatingActionButton(
                      elevation: 10,
                      backgroundColor: Colors.grey[700],
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPage(
                                      deviceID: "0a-af-ff-2b",
                                      name: deviceName,
                                    )));
                      },
                      child: Transform.translate(
                          offset: const Offset(-5, 5),
                          child:
                              Icon(Icons.edit, size: 20, color: Colors.white)),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(
                      Alignment.topCenter.x, Alignment.topCenter.y + 0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Card(
                      color: Colors.blueGrey,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: provider.pageState == 1
                              ? Text(
                                  "BENNE BÂCHÉE",
                                  textScaleFactor: 2.5,
                                  style: TextStyle(
                                      color: Colors.white, letterSpacing: 5),
                                )
                              : provider.pageState == 3
                                  ? Text(
                                      "BENNE DÉBÂCHÉE",
                                      textScaleFactor: 2.3,
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 5),
                                    )
                                  : provider.pageState == 2
                                      ? Text(
                                          "BÂCHE EN COURS DE MOUVEMENT",
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 2.4,
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 5),
                                        )
                                      : Text(
                                          "BÂCHE EN POSITION INTERMÉDIAIRE",
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 2.2,
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 5),
                                        )),
                    ),
                  ),
                ),
                IconCommande(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 90.0),
                      child: provider.pageState == 1
                          ? Text("Appuyer sur l'icône pour débâcher",
                              textScaleFactor: 1.8,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black))
                          : provider.pageState == 3
                              ? Text("Appuyer sur l'icône pour bâcher",
                                  textScaleFactor: 1.8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black))
                              : provider.pageState == 2
                                  ? Text(
                                      "Appuyer sur l'icône pour stopper l'action en cours",
                                      textScaleFactor: 1.8,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black))
                                  : Text("Selectionner une action",
                                      textScaleFactor: 1.8,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black))),
                ),
              ],
            ),
          ));
        }));
  }
}
