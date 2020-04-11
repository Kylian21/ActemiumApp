import 'dart:async';
import 'package:actemium_app/MainPage/MainPageProvider.dart';
import 'package:actemium_app/MainPage/MyBottomNavBar.dart';
import 'package:actemium_app/MainPage/MyFAB.dart';
import 'package:actemium_app/MainPage/mainPageTile.dart';
import 'package:actemium_app/ConfigSize.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:system_setting/system_setting.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamController<List<BluetoothDevice>> _streamController =
      StreamController<List<BluetoothDevice>>.broadcast();
  static final List<BluetoothDevice> deviceList = new List<BluetoothDevice>();
  final ScrollController myScrollController = new ScrollController();
  ScrollController dragScrolController = new ScrollController();

  @override
  void initState() {
    //checkBluetooth();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myScrollController.dispose();
    _streamController.done;
  }

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    dragScrolController = new ScrollController(
        initialScrollOffset: ConfigSize.blockSizeVertical * 30);
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: NestedScrollView(
              controller: myScrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: ConfigSize.blockSizeVertical * 30,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        "Appairage Bluetooth",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: ConfigSize.blockSizeVertical * 3,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Open Sans'),
                      ),
                      background: Image.asset('assets/images/BENALU.png'),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: EdgeInsets.only(
                    top: ConfigSize.blockSizeVertical * 3,
                    bottom: ConfigSize.blockSizeVertical * 4),
                child: StreamBuilder<List<BluetoothDevice>>(
                    stream: _streamController.stream,
                    initialData: [],
                    builder: (BuildContext context,
                        AsyncSnapshot<List<BluetoothDevice>> snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : DraggableScrollbar.semicircle(
                              heightScrollThumb: 60,
                              //controller: dragScrollController,
                              alwaysVisibleScrollThumb: true,
                              child: ListView.builder(
                                itemCount: 15, //snapshot.data.length,
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
              )),
          floatingActionButton: MyFAB(
            streamController: _streamController,
          ),
          bottomNavigationBar: MyBottomNavBar()),
    );
  }

  /*void checkBluetooth() async {
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
  }*/
}
