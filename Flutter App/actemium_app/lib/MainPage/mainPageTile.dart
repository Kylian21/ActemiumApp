import 'package:actemium_app/BluetoothParameters.dart';
import 'package:actemium_app/MainPage/MainPageProvider.dart';
import 'package:actemium_app/MainPage/PasswordDialogue.dart';
import 'package:actemium_app/commandsPage/ScaleTransition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:actemium_app/CommandsPage/CommandsPage.dart';
import '../ConfigSize.dart';
import '../benne_icons.dart';

class MainPageTile extends StatelessWidget {
  final String text;
  final BluetoothDevice device;
  final FlutterBlue flutterBlue;

  MainPageTile(
      {Key key,
      @required this.text,
      @required this.device,
      @required this.flutterBlue})
      : super(key: key);

  final Key myKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainPageProvider>(context);
    BluetoothParameters _parameters = new BluetoothParameters();
    

    return InkWell(
      key: myKey,
      onTap: () async {
        /*when the card is selected we provide the key to the provider
        which it will rebuild the cards and change the state of the
        unamed one.*/
        //_parameters.getCharacteristicsFromService(this.device,Guid("0xOFFDE"));
        provider.cardState = myKey;
        //bluetoothConnect(context);
        var navigate = await showDialog(
            context: context,
            builder: (_) {
              return PasswordDialogue();
            });

        if (navigate) {
          Future.delayed(Duration(seconds: 1), () {
            
            //this methode will reset to null the provider but not notify the
            //listener to avoid useless rebuild
            provider.resetProvider();
            Navigator.push(
                context, ScaleRoute(page: CommandsPage(deviceName: this.text)));
          });
        } else {
          provider.cardState = null;
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: ConfigSize.blockSizeHorizontal * 3,
            vertical: ConfigSize.blockSizeVertical * 1.5),
        shape: ContinuousRectangleBorder(
            side: BorderSide(
                color: Colors.blueGrey,
                width: ConfigSize.blockSizeVertical * 0.5)),
        color: provider.cardState == myKey ? Colors.blueGrey : Colors.white,
        elevation: provider.cardState == myKey ? 6 : 2,
        child: Container(
          height: ConfigSize.blockSizeHorizontal * 24,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(left: ConfigSize.blockSizeHorizontal * 2),
                child: Icon(
                  Benne.bachee,
                  color: provider.cardState == myKey
                      ? Colors.grey[100]
                      : Colors.grey[800],
                  size: ConfigSize.blockSizeVertical * 8,
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: ConfigSize.blockSizeHorizontal * 6),
                  child: Text(
                    this.text,
                    style: TextStyle(
                      letterSpacing: 7,
                      fontSize: ConfigSize.blockSizeVertical * 3,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Open Sans',
                      color: provider.cardState != null
                          ? Colors.grey[100]
                          : Colors.grey[800],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void bluetoothConnect(BuildContext context) async {
    try {
      await this.device.connect();
      print("Connection established with device {${this.device.name}}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  CommandsPage(deviceName: this.text)));
    } catch (e) {
      if (e.code != "alreadyConnected") {
        throw e;
      }
    }
  }
}
