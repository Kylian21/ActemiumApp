import 'dart:async';
import 'package:actemium_app/MainPageProvider.dart';
import 'package:actemium_app/mainPageTile.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:system_setting/system_setting.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamController<List<BluetoothDevice>> _streamController =
      StreamController<List<BluetoothDevice>>.broadcast();
  static final List<BluetoothDevice> deviceList = new List<BluetoothDevice>();
  ScrollController myScrollController = new ScrollController();

  @override
  void initState() {
    //checkBluetooth();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Appairage Bluetooth",
            textScaleFactor: 1.3,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey,Colors.grey]
              )
          ),
          child: Stack(
            alignment: Alignment(Alignment.center.x,Alignment.center.y),
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height/1.5,
                child: StreamBuilder<List<BluetoothDevice>>(
                    stream: _streamController.stream,
                    initialData: [],
                    builder: (BuildContext context,
                        AsyncSnapshot<List<BluetoothDevice>> snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : DraggableScrollbar.semicircle(
                              controller: myScrollController,
                              alwaysVisibleScrollThumb: true,
                              child: ListView.separated(
                                controller: myScrollController,
                                itemCount: 15, //snapshot.data.length,
                                separatorBuilder: (context, index) => Divider(),
                                itemBuilder: (context, index) {
                                  return MainPageTile(
                                      text: "WH - 00$index - TH",
                                      device: null,
                                      flutterBlue: null);
                                  /*return MainPageTile(
                                  text: snapshot.data[index].name,
                                  device: snapshot.data[index],
                                  flutterBlue: flutterBlue,
                                );*/
                                },
                              ),
                            );
                    }),
              ),
            ],

          ),
        ),
        floatingActionButton:
            Consumer<MainPageProvider>(builder: (context, provider, _) {
          if (provider.cardState != null) {
            return FloatingActionButton.extended(
              onPressed: () {
                provider.cardState = null;
              },
              label: Text("Connexion en cours"),
              icon: Icon(Icons.bluetooth_searching),
            );
          } else {
            return StreamBuilder(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return FloatingActionButton.extended(
                          onPressed: null,
                          label: Text("Aucune connexion Bluetooth!"));
                      break;
                    case ConnectionState.active:
                      return FloatingActionButton(
                        onPressed: null,
                        child: SpinKitRing(
                          color: Colors.green,
                        ),
                      );
                      break;
                    default:
                      return FloatingActionButton.extended(
                        onPressed: (){
                          provider.cardState = null;
                          checkBluetooth();
                        },
                        label: Text("Appuyez pour rafraîchir"),
                        backgroundColor: Colors.deepPurple,
                        icon: Icon(Icons.autorenew),
                      );
                  }
                });
          }
        }),
        bottomNavigationBar:
            Consumer<MainPageProvider>(builder: (context, provider, _) {
          if (provider.cardState == null) {
            return Container(
              color: Colors.grey,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Sélectionner une benne sur laquelle vous connecter",
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  )),
            );
          } else {
            return Container(
              height: 2,
              color: Colors.grey,
            );
          }
        }),
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
      flutterBlue.stopScan();
      bluetoothStartScan();
    }
  }

  _jumpToSetting() {
    SystemSetting.goto(SettingTarget.BLUETOOTH);
  }

  void bluetoothStartScan() {
    deviceList.clear();
    flutterBlue.scan(timeout: Duration(seconds: 5)).listen((scanResult) {
      if (deviceList.indexOf(scanResult.device) == -1) {
        deviceList.add(scanResult.device);
      }
      _streamController.sink.add(deviceList);
    }, onDone: (() {
      print("Stream done");
      _streamController.close();
      _streamController =
          new StreamController<List<BluetoothDevice>>.broadcast();
    }));
  }
}
