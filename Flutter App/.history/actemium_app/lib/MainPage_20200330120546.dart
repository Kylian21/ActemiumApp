import 'dart:async';
import 'package:actemium_app/mainPageTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:system_setting/system_setting.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final StreamController<List<BluetoothDevice>> _streamController =
      StreamController<List<BluetoothDevice>>.broadcast();
  static final List<BluetoothDevice> deviceList = new List<BluetoothDevice>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    //checkBluetooth();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
      });
    }
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
          StreamBuilder(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              switch(snapshot.connectionState){
                case ConnectionState.none:
                  return Text("Erreur de connection");
                case ConnectionState.done:
                  return IconButton(icon: Icon(Icons.check,color: Colors.green,), onPressed: null);
                  break;
                case ConnectionState.waiting:
                  return IconButton(
                        icon: Icon(Icons.autorenew),
                        iconSize: 60,
                        color: Colors.green[300],
                        onPressed: () {
                          setState(() {
                            checkBluetooth();
                          });
                        },
                      );
                  break;
                case ConnectionState.active:
                  return SpinKitCircle(color: null);
                  break;
              }      
            },
          ),
          Flexible(
            child: StreamBuilder<List<BluetoothDevice>>(
                stream: _streamController.stream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<BluetoothDevice>> snapshot) {
                  return !snapshot.hasData
                      ? Text("Appuyer sur le bouton rafraichir pour recevoir")
                      : ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return MainPageTile(
                              text: snapshot.data[index].id.toString(),
                              device: snapshot.data[index],
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
    } else if (!isOn) {
      return showDialog(
          context: context,
          child: AlertDialog(
              title: Text("Le Bluetooth est désactivé"),
              content: RaisedButton(
                onPressed: _jumpToSetting,
                child: Text('Activer'),
              )));
    } else {
      bluetoothStartScan();
    }
  }

  _jumpToSetting() {
    SystemSetting.goto(SettingTarget.BLUETOOTH);
  }

  void bluetoothStartScan() {
    flutterBlue.scan(timeout: Duration(seconds: 10)).listen((scanResult) {
      if (deviceList.indexOf(scanResult.device) == -1) {
        deviceList.add(scanResult.device);
      }
      _streamController.sink.add(deviceList);
    },onDone: ((){print("Stream done");dispose();})
    );
  }
}
