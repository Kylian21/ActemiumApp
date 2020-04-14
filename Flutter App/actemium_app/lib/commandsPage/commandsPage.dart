import 'package:actemium_app/commandsPage/CommandsCard.dart';
import 'package:actemium_app/commandsPage/CommandsIcon.dart';
import 'package:actemium_app/commandsPage/CommandsInstruction.dart';
import 'package:actemium_app/commandsPage/commandsPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:actemium_app/EditPage/EditPage.dart';
import '../ConfigSize.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class CommandsPage extends StatelessWidget {
  //final BluetoothDevice device;
  final String deviceName;

  CommandsPage({Key key, @required this.deviceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    return ChangeNotifierProvider(
      create: (context) => CommandsPageProvider(),
      child: SafeArea(
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
              CommandsCard(),
              CommandsIcon(),
              CommandsInstruction(),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text(
              "Paramètres",
              style: TextStyle(fontSize: ConfigSize.blockSizeHorizontal * 7),
            ),
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
            icon: Icon(Icons.edit,
                size: ConfigSize.blockSizeHorizontal * 10,
                color: Colors.grey[100]),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      )),
    );
  }
}
