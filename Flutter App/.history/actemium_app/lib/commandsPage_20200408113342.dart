import 'dart:async';
import 'package:actemium_app/IconCommandePage.dart';
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
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.scale(
                    scale: 2,
                    child: FloatingActionButton(
                      onPressed: null,
                      child: Icon(Icons.edit, color: Colors.blueGrey),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
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
