import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:actemium_app/commandsPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconCommande extends StatelessWidget {
  IconCommande({
    Key key,
  }) : super(key: key);

  Timer myTimer = Timer(Duration(seconds: 3), () {});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommandsPageProvider>(context);

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
              myTimer = Timer(Duration(seconds: 3), () {
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
                myTimer.cancel();
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
                provider.pageState = 2;
                myTimer = Timer(Duration(seconds: 3), () {
                  provider.pageState = 1;
                });
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
}
