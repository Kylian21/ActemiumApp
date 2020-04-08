import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:actemium_app/commandsPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconCommands extends StatelessWidget {
  IconCommands({
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
            iconSize: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 12),
            splashColor: Colors.grey[700],
            icon: Image.asset('assets/images/bachee.png'),
            onPressed: () {
              provider.pageState = 2;
              /*myTimer = Timer(Duration(seconds: 3), () {
                provider.pageState = 3;
              });*/
            },
          ),
        );
        break;
      case 2:
        return Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 12),
              icon: Image.asset('assets/images/stop.png'),
              onPressed: () {
                //myTimer.cancel();
                provider.pageState = 4;
              },
            ));
        break;
      case 3:
        return Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 12),
              icon: Image.asset('assets/images/debachee.png'),
              onPressed: () {
                /*myTimer = Timer(Duration(seconds: 3), () {
                  provider.pageState = 1;
                });*/
                provider.pageState = 2;
              },
            ));
        break;
      case 4:
        return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.warning,
                    size: MediaQuery.of(context).size.height/4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shape: ContinuousRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width / 250)),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width / 15),
                          child: FlatButton(
                            onPressed: () {
                              provider.pageState = 1;
                            },
                            child: Text(
                              "BÂCHER",
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Colors.grey[800], letterSpacing: 5),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4.0,
                        shape: ContinuousRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey[700],
                                width: MediaQuery.of(context).size.width / 250)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 15,
                              bottom: MediaQuery.of(context).size.width / 15,
                              right: MediaQuery.of(context).size.width / 30,
                              left: MediaQuery.of(context).size.width / 30),
                          child: FlatButton(
                            onPressed: () {
                              provider.pageState = 3;
                            },
                            child: Text(
                              "DÉBÂCHER",
                              textScaleFactor:
                                  MediaQuery.of(context).size.height / 500,
                              style: TextStyle(
                                  color: Colors.grey[800], letterSpacing: 5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
        break;
      default:
        return Container(child: Text("Erreur, relancez la connexion"));
    }
  }
}
