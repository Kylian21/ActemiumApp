import 'dart:async';
import 'package:actemium_app/mainPageTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

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
  //StreamSubscription<ScanResult> scanSubScription;
  final StreamController<List<String>> _streamController =
      StreamController<List<String>>.broadcast();
  static final List<String> deviceList = new List<String>();
  BluetoothCharacteristic targetCharacteristic;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

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
            child: StreamBuilder<List<String>>(
                stream: _streamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  return !snapshot.hasData
                      ? MainPageTile(text: "Appuyer sur le bouton rafraichir pour recevoir",)
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return MainPageTile(
                              text: snapshot.data[index],
                            );
                          },
                        );
                }),
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
            content: Text(
                "Veuillez activer le bluetooth"),
          ));
    }
    else{
      bluetoothStartScan();
    }
  }

  void bluetoothStartScan() {
        flutterBlue.scan(timeout: Duration(seconds: 10)).listen((scanResult) {
      if (deviceList.indexOf(scanResult.device.id.toString()) == -1) {
        deviceList.add(scanResult.device.id.toString());
      }
      _streamController.sink.add(deviceList);
    });
  }
}
