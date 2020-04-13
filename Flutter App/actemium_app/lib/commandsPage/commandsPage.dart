import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:actemium_app/CommandsPage/commandsPageProvider.dart';
import 'package:actemium_app/EditPage/EditPage.dart';
import 'package:actemium_app/CommandsPage/CommandsCard.dart';
import 'package:actemium_app/CommandsPage/CommandsIcon.dart';
import 'package:actemium_app/CommandsPage/CommandsInstruction.dart';

import '../ConfigSize.dart';

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
            child: Scaffold(
              appBar: AppBar(
                elevation: 10,
                backgroundColor: Colors.grey[100],
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Colors.grey[800]),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  "$deviceName",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: ConfigSize.blockSizeVertical * 4.5,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Open Sans'),
                ),
              ),
              body: Stack(
                children: <Widget>[
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
                  CommandsCard(),
                  CommandsIcon(),
                  CommandsInstruction(),
                ],
              ),
            ),
          ));
        }));
  }
}
