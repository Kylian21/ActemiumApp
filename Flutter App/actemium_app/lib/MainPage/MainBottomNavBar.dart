import 'package:actemium_app/ConfigSize.dart';
import 'package:actemium_app/MainPage/MainPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//This widget just display a text if the user has selected nothing
class MyBottomNavBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<MainPageProvider>(
      //This Consumer listen the MainPageProvider and will rebuild if it state change.
      //The value is in the instance of Provider : provider (in the builder)
      builder: (context, provider, _) {
      if (provider.cardState == null) {
        return Container(
          color: Colors.grey[100],
          child: Padding(
              padding: EdgeInsets.only(
                  bottom: ConfigSize.blockSizeVertical * 2,
                  left: ConfigSize.blockSizeHorizontal * 4,
                  right: ConfigSize.blockSizeHorizontal * 4),
              child: Text(
                "Sélectionner une benne sur laquelle vous connecter",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: ConfigSize.blockSizeVertical * 2.5,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Open Sans'),
              )),
        );
      } else {
        return Container(
          height: ConfigSize.blockSizeVertical * 7,
          color: Colors.transparent,
        );
      }
    });
  }
}
