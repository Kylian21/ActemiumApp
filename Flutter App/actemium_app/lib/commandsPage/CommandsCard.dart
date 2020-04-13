import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actemium_app/CommandsPage/CommandsPageProvider.dart';
import 'package:provider/provider.dart';
import '../ConfigSize.dart';

class CommandsCard extends StatelessWidget {
  CommandsCard({
    Key key,
  }) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommandsPageProvider>(context);
    return Align(
      alignment: Alignment(Alignment.topCenter.x,
          Alignment.topCenter.y + ConfigSize.blockSizeVertical * 0.04),
      child: Padding(
        padding: EdgeInsets.only(
            right: ConfigSize.blockSizeHorizontal * 3,
            left: ConfigSize.blockSizeHorizontal * 3),
        child: Card(
          color: Colors.blueGrey,
          elevation: 4.0,
          shape: ContinuousRectangleBorder(),
          child: Padding(
              padding: EdgeInsets.all(ConfigSize.blockSizeVertical * 3),
              child: provider.pageState == 1
                  ? Text(
                      "BENNE BÂCHÉE",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 7,
                        fontSize: ConfigSize.blockSizeVertical * 4,
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
                            fontSize: ConfigSize.blockSizeVertical * 3.3,
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
                                fontSize: ConfigSize.blockSizeVertical * 3,
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
                                fontSize: ConfigSize.blockSizeVertical * 3,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Open Sans',
                              ),
                            )),
        ),
      ),
    );
  }
}
