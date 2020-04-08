import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:actemium_app/commandsPageProvider.dart';

class CommandsPage extends StatelessWidget {
  //final BluetoothDevice device;
  final String deviceName;

  CommandsPage({Key key, @required this.deviceName}) : super(key: key);
  Timer t = Timer(Duration(seconds: 3), () {});

  @override
  Widget build(BuildContext context) {
    //String deviceName = device.name;
    return ChangeNotifierProvider(
        create: (context) => CommandsPageProvider(),
        child: Consumer<CommandsPageProvider>(builder: (context, provider, _) {
          final provider = Provider.of<CommandsPageProvider>(context);
          Widget _buildIcon() {
            switch (provider.pageState) {
              case 1:
                return Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    iconSize: 350,
                    padding: const EdgeInsets.all(8.0),
                    splashColor: Colors.grey[700],
                    icon: Image.asset('assets/images/bachee.png'),
                    onPressed: () {
                      provider.pageState = 2;
                      Timer t = Timer(Duration(seconds: 3), () {
                        provider.pageState = 3;
                      });
                    },
                  ),
                );
                break;
              case 2:
                return Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 350,
                      padding: const EdgeInsets.all(8.0),
                      icon: Image.asset('assets/images/stop.png'),
                      onPressed: () {
                        t.cancel();
                        provider.pageState = 4;
                      },
                    ));
                break;
              case 3:
                return Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 350,
                      padding: const EdgeInsets.all(8.0),
                      icon: Image.asset('assets/images/debachee.png'),
                      onPressed: () {
                        Timer t = Timer(Duration(seconds: 3), () {
                          provider.pageState = 1;
                        });
                        provider.pageState = 2;
                      },
                    ));
                break;
              case 4:
                return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.warning,
                          size: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              color: Colors.black,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(25),
                                child: FlatButton(
                                  onPressed: () {
                                    provider.pageState = 1;
                                  },
                                  child: Text(
                                    "BÂCHER",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                        color: Colors.white, letterSpacing: 5),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.black,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 25, right: 16, left: 16),
                                child: FlatButton(
                                  onPressed: () {
                                    provider.pageState = 3;
                                  },
                                  child: Text(
                                    "DÉBÂCHER",
                                    textScaleFactor: 1.3,
                                    style: TextStyle(
                                        color: Colors.white, letterSpacing: 5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
                break;
              default:
                return Container(child: Text("Erreur, relancez la connexion"));
            }
          }

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  "Benne connectée : $deviceName",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Card(
                        color: Colors.black,
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
                  _buildIcon(),
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
              ));
        }));
  }
}
