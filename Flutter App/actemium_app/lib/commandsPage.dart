import 'dart:async';
import 'package:actemium_app/IconCommandsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:actemium_app/commandsPageProvider.dart';

import 'EditPage.dart';

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
                AppBar(
                  elevation: 10,
                  backgroundColor: Colors.grey[100],
                  leading: new IconButton(
                    icon:
                        new Icon(Icons.arrow_back_ios, color: Colors.grey[800]),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    "$deviceName",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: MediaQuery.of(context).size.height / 19,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans'),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Transform.scale(
                    scale: MediaQuery.of(context).size.height / 450,
                    child: FloatingActionButton(
                      elevation: 3,
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPage(
                                      deviceID: "0a-af-ff-2b",
                                      name: deviceName,
                                    )));
                      },
                      child: Icon(Icons.edit,
                          size: MediaQuery.of(context).size.height / 30,
                          color: Colors.grey[100]),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(
                      Alignment.topCenter.x, Alignment.topCenter.y + MediaQuery.of(context).size.height/2000),
                  child: Padding(
                    padding: EdgeInsets.only(right : MediaQuery.of(context).size.width/50,left: MediaQuery.of(context).size.width/50),
                    child: Card(
                      color: Colors.blueGrey,
                      elevation: 4.0,
                      shape: ContinuousRectangleBorder(),
                      child: Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.height/30),
                          child: provider.pageState == 1
                              ? Text(
                                  "BENNE BÂCHÉE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 7,
                                    fontSize:
                                        MediaQuery.of(context).size.height / 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Open Sans',
                                  ),
                                )
                              : provider.pageState == 3
                                  ? Text(
                                      "BENNE DÉBÂCHÉE",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 7,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                24,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Open Sans',
                                      ),
                                    )
                                  : provider.pageState == 2
                                      ? Text(
                                          "BÂCHE EN COURS DE MOUVEMENT",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 7,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Open Sans',
                                          ),
                                        )
                                      : Text(
                                          "BÂCHE EN POSITION INTERMÉDIAIRE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            letterSpacing: 7,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                30,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Open Sans',
                                          ),
                                        )),
                    ),
                  ),
                ),
                IconCommands(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 27,
                          right: MediaQuery.of(context).size.width / 27,
                          bottom: MediaQuery.of(context).size.height / 10),
                      child: provider.pageState == 1
                          ? Text(
                              "Appuyer sur l'icône pour débâcher",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize:
                                      MediaQuery.of(context).size.height / 30,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'Open Sans'),
                            )
                          : provider.pageState == 3
                              ? Text(
                                  "Appuyer sur l'icône pour bâcher",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Open Sans'),
                                )
                              : provider.pageState == 2
                                  ? Text(
                                      "Appuyer sur l'icône pour stopper l'action en cours",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans'),
                                    )
                                  : Text(
                                      "Selectionner une action",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Open Sans'),
                                    )),
                ),
              ],
            ),
          ));
        }));
  }
}
