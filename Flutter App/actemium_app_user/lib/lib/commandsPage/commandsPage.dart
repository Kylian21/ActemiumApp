import 'package:actemium_app_user/lib/commandsPage/CommandsCard.dart';
import 'package:actemium_app_user/lib/commandsPage/CommandsIcon.dart';
import 'package:actemium_app_user/lib/commandsPage/CommandsInstruction.dart';
import 'package:actemium_app_user/lib/commandsPage/commandsPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import '../ConfigSize.dart';
//import 'package:flutter_blue/flutter_blue.dart';

class CommandsPage extends StatelessWidget {
  
  final String deviceName;
  /*
  # Those instances are used for dealing with Bluetooth device
    final BluetoothDevice device;
    BluetoothParameters _parameters = new BluetoothParameters();
    BluetoothCharacteristic _characteristic;
  */

  CommandsPage({Key key, 
  @required this.deviceName,
  //@required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //_characteristic = _parameters.getCharacteristicsFromService(this.device, Guid("Choose an UUID"))[0];

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
              /*StreamBuilder(
                stream: _characteristic.value,
                builder: (context,snapshot){
                  AlertDialog(
                    title: Text("Camion en mouvement"),
                    content: Icon(Icons.warning,color: Colors.red,),
                  );
                }),*/
              CommandsCard(),
              CommandsIcon(),
              CommandsInstruction(),
            ],
          ),
        ),
      )),
    );
  }
}
