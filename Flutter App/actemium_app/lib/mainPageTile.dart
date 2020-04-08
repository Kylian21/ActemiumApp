import 'package:actemium_app/MainPageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

import 'commandsPage.dart';

class MainPageTile extends StatelessWidget {
  final String text;
  final BluetoothDevice device;
  final FlutterBlue flutterBlue;
  final Key myKey = UniqueKey();

  MainPageTile(
      {Key key,
      @required this.text,
      @required this.device,
      @required this.flutterBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainPageProvider>(context);
    final noRebuildProvider =
        Provider.of<MainPageProvider>(context, listen: false);

    return InkWell(
      key: myKey,
      onTap: () {
        /*when the card is selected we provide the key to the provider
        which it will rebuild the cards and change the state of the
        unamed one.*/

        provider.cardState = myKey;
        //bluetoothConnect(context);
        Future.delayed(const Duration(milliseconds: 3000), () {
          noRebuildProvider.cardState = null;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommandsPage(deviceName: this.text)));
        });
      },
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20,
            vertical: MediaQuery.of(context).size.height / 100),
        shape:
            ContinuousRectangleBorder(side: BorderSide(color: Colors.blueGrey,width: MediaQuery.of(context).size.width / 180)),
        color: provider.cardState == myKey ? Colors.blueGrey : Colors.white,
        elevation: provider.cardState == myKey ? 6 : 2,
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 60),
                child: Icon(
                  Icons.airport_shuttle,
                  color: provider.cardState == myKey
                      ? Colors.grey[100]
                      : Colors.grey[800],
                  size: MediaQuery.of(context).size.height / 12,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    this.text,
                    style: TextStyle(
                      letterSpacing: 7,
                      fontSize: MediaQuery.of(context).size.height / 31,
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
      await device.connect();
      print("Connection established with device {${device.name}}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  CommandsPage(deviceName: text)));
    } catch (e) {
      if (e.code != "alreadyConnected") {
        throw e;
      }
    }
  }
}
