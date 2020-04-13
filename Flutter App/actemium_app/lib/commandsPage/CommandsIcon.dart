import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:actemium_app/CommandsPage/CommandsPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ConfigSize.dart';

class CommandsIcon extends StatelessWidget {
  CommandsIcon({
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
            iconSize: ConfigSize.blockSizeVertical * 50,
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
              iconSize: ConfigSize.blockSizeVertical * 50,
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
              iconSize: ConfigSize.blockSizeVertical * 50,
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
              padding:
                  EdgeInsets.only(top: ConfigSize.blockSizeVertical * 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.warning,
                    size: ConfigSize.blockSizeVertical * 25,
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
                                width:
                                    ConfigSize.blockSizeHorizontal * 0.5)),
                        child: Padding(
                          padding: EdgeInsets.all(
                              ConfigSize.blockSizeHorizontal * 5.5),
                          child: FlatButton(
                            onPressed: () {
                              provider.pageState = 1;
                            },
                            child: Text(
                              "BÂCHER",
                              style: TextStyle(
                                fontSize: ConfigSize.blockSizeVertical*2.5,
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
                                width:
                                    ConfigSize.blockSizeHorizontal * 0.5)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ConfigSize.blockSizeHorizontal * 5.5,
                              bottom: ConfigSize.blockSizeHorizontal * 5.5,
                              right: ConfigSize.blockSizeHorizontal * 1,
                              left: ConfigSize.blockSizeHorizontal * 1),
                          child: FlatButton(
                            onPressed: () {
                              provider.pageState = 3;
                            },
                            child: Text(
                              "DÉBÂCHER",
                              style: TextStyle(
                                fontSize: ConfigSize.blockSizeVertical*2.5,
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
