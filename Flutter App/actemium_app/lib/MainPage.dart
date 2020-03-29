import 'dart:async';
import 'package:actemium_app/mainPageTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:system_setting/system_setting.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    checkBluetooth();
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;

  StreamSubscription<ScanResult> scanSubScription;

  List<BluetoothDevice> deviceList = new List<BluetoothDevice>();

  BluetoothCharacteristic targetCharacteristic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("Menu Principal"),
      ),
      body: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.autorenew),
            iconSize: 60,
            color: Colors.green[300],
            onPressed: () {
              setState(() {
                checkBluetooth();
              });
            },
          ),
          Text("Appuyer pour rafaichir"),
          Flexible(
            child: ListView.builder(
              itemCount: deviceList.length,
              itemBuilder: (context, index) {
                return MainPageTile(
                  text: deviceList[index].name,
                  device: deviceList[index],
                );
              },
            ),
          ),
          Text("Sélectionner une benne sur laquelle vous connecter")
        ],
      ),
    );
  }

  void checkBluetooth() async {
    bool isAvailable = await flutterBlue.isAvailable;
    bool isOn = await flutterBlue.isOn;
    if (!isAvailable) {
      return showDialog(
          context: context,
          child: AlertDialog(
            title: Text("Votre appareil n'est pas compatible"),
            content: Text(
                "Vous ne disposez pas d'un appareil possédant la fonctionnalité à jour du bluetooth indispensable pour utiliser l'application."),
          ));
    }
    else if(!isOn){
      return showDialog(
          context: context,
          child: AlertDialog(
            title: Text("Le Bluetooth est désactivé"),
            content: RaisedButton(
              onPressed: _jumpToSetting,
              child: Text('Activer'),
            )
          ));
    }
    else{
      bluetoothStartScan();
    }
  }
  _jumpToSetting(){
    SystemSetting.goto(SettingTarget.BLUETOOTH);
  }

  void bluetoothStartScan() {
    scanSubScription =
        flutterBlue.scan(timeout: Duration(seconds: 4)).listen((scanResult) {
      deviceList.add(scanResult.device);
    });
  }
}
