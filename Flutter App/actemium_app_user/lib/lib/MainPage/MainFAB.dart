import 'dart:async';
import 'package:actemium_app_user/lib/ConfigSize.dart';
import 'package:actemium_app_user/lib/MainPage/MainPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyFAB extends StatelessWidget {
  final StreamController<List<BluetoothDevice>> streamController;

  MyFAB({Key key, this.streamController}) : super(key: key);

  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(builder: (context, provider, _) {
      //The consumer Class is a listener of MainPage provider and
      //will rebuild whenever the provider change is state. We access the value of the provider
      //with the instance of provider in the builder.
      if (provider.cardState != null) {
        return FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            provider.cardState = null;
          },
          label: Text(
            "Connexion en cours",
            style: TextStyle(
                color: Colors.white,
                fontSize: ConfigSize.blockSizeVertical * 2,
                fontWeight: FontWeight.w400,
                fontFamily: 'Open Sans'),
          ),
          icon: Icon(Icons.bluetooth_searching),
        );
      } else {
        return StreamBuilder(
            stream: this.streamController.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return FloatingActionButton.extended(
                      onPressed: null,
                      label: Text("Aucune connexion Bluetooth!"));
                  break;
                case ConnectionState.active:
                  return FloatingActionButton(
                    onPressed: null,
                    backgroundColor: Colors.blueGrey,
                    child: SpinKitRing(
                      color: Colors.white,
                    ),
                  );
                  break;
                default:
                  return FloatingActionButton.extended(
                    onPressed: () {
                      provider.cardState = null;
                      //this methode have to be called from the mainPage class
                      //checkBluetooth();
                    },
                    label: Text(
                      "Appuyez pour rafraîchir",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ConfigSize.blockSizeVertical * 2,
                          fontFamily: 'Open Sans'),
                    ),
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    icon: Icon(
                      Icons.autorenew,
                      color: Colors.white,
                    ),
                  );
              }
            });
      }
    });
  }
}
