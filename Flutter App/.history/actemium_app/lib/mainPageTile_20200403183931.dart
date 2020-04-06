import 'package:actemium_app/MainPageProvider.dart';
import 'package:actemium_app/deviceServicesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

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

    return InkWell(
      key: myKey,
      onTap: () {
        /*when the card is selected we provide the key to the provider
        which it will rebuild the cards and change the state of the
        unamed one.*/

        provider.cardState = myKey;
        //bluetoothConnect(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.airport_shuttle,
              color:
                  provider.cardState == myKey || provider.cardState == null
                      ? Colors.black
                      : Colors.grey[400],
              size: 40,
            ),
            Text(
              this.text,
              style: TextStyle(
                  fontSize: 30,
                  color: provider.cardState == myKey ||
                          provider.cardState == null
                      ? Colors.black
                      : Colors.grey[400]),
              textAlign: TextAlign.center,
            )
          ],
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
                  DeviceServicesPage(device: device)));
    } catch (e) {
      if (e.code != "alreadyConnected") {
        throw e;
      }
    }
  }
}
