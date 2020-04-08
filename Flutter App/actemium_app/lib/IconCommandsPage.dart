import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:actemium_app/commandsPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconCommande extends StatelessWidget {
  
  IconCommande({Key key,}) : super(key: key);
  
  Timer myTimer = Timer(Duration(seconds: 3),(){});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommandsPageProvider>(context);
    

    switch (provider.pageState) {
      case 1:
        return Align(
          alignment: Alignment.center,
          child: IconButton(
<<<<<<< Updated upstream:Flutter App/actemium_app/lib/IconCommandePage.dart
            color: Colors.grey[50],
            iconSize: 350,
            padding: const EdgeInsets.all(8.0),
=======
            iconSize: MediaQuery.of(context).size.height/2,
            padding: EdgeInsets.all(MediaQuery.of(context).size.height/12),
>>>>>>> Stashed changes:Flutter App/actemium_app/lib/IconCommandsPage.dart
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
              iconSize: MediaQuery.of(context).size.height/2,
              padding: EdgeInsets.all(MediaQuery.of(context).size.height/12),
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
              iconSize: MediaQuery.of(context).size.height/2,
              padding: EdgeInsets.all(MediaQuery.of(context).size.height/12),
              icon: Image.asset('assets/images/debachee.png'),
              onPressed: () {
                /*myTimer = Timer(Duration(seconds: 3), () {
                  provider.pageState = 1;
<<<<<<< Updated upstream:Flutter App/actemium_app/lib/IconCommandePage.dart
                });
                
=======
                });*/
                provider.pageState = 2;
>>>>>>> Stashed changes:Flutter App/actemium_app/lib/IconCommandsPage.dart
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
                      color: Colors.blueGrey,
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
                            textScaleFactor: MediaQuery.of(context).size.height/500,
                            style: TextStyle(
                                color: Colors.black, letterSpacing: 5),
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
