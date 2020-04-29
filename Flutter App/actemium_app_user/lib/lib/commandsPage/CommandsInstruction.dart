import 'package:actemium_app_user/lib/commandsPage/commandsPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ConfigSize.dart';

class CommandsInstruction extends StatelessWidget {
  CommandsInstruction({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final _provider = Provider.of<CommandsPageProvider>(context);
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: EdgeInsets.only(
                left: ConfigSize.blockSizeHorizontal * 5,
                right: ConfigSize.blockSizeHorizontal * 5,
                bottom: ConfigSize.blockSizeVertical * 18),
            child: _provider.pageState == 1
                ? Text(
                    "Appuyer sur l'icône pour débâcher",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: ConfigSize.blockSizeHorizontal * 6,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans'),
                  )
                : _provider.pageState == 3
                    ? Text(
                        "Appuyer sur l'icône pour bâcher",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: ConfigSize.blockSizeHorizontal * 6,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans'),
                      )
                    : _provider.pageState == 2
                        ? Text(
                            "Appuyer sur l'icône pour stopper l'action en cours",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: ConfigSize.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans'),
                          )
                        : Text(
                            "Selectionner une action",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: ConfigSize.blockSizeHorizontal * 6,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans'),
                          )),
      );
  }
}
