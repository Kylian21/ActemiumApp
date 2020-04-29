import 'dart:async';

import 'package:actemium_app_user/lib/ConfigSize.dart';
import 'package:actemium_app_user/lib/MainPage/MainBottomNavBar.dart';
import 'package:actemium_app_user/lib/MainPage/MainFAB.dart';
import 'package:actemium_app_user/lib/MainPage/MainPageProvider.dart';
import 'package:actemium_app_user/lib/MainPage/mainPageTile.dart';
import 'package:actemium_app_user/lib/Tools/FadeOnScroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:system_setting/system_setting.dart';

//This page is responsible for displaying the bluetooth devices and connect
//to them, and also refresh the devices list.

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /*
  # This instance of FlutterBlue allow you to use the Bluetooth methode
     FlutterBlue flutterBlue = FlutterBlue.instance;
   */
  //FlutterBlue flutterBlue = FlutterBlue.instance;

  StreamController<List<BluetoothDevice>> _streamController =
      StreamController<List<BluetoothDevice>>.broadcast();
  static final List<BluetoothDevice> deviceList = new List<BluetoothDevice>();
  final ScrollController myScrollController =
      new ScrollController(initialScrollOffset: 0.0);
  RegExp immatriculationRegExp = RegExp(
      '[A-HJ-NP-TV-Z]{2}[\s-]{0,1}[0-9]{3}[\s-]{0,1}[A-HJ-NP-TV-Z]{2}|[0-9]{2,4}[\s-]{0,1}[A-Z]{1,3}[\s-]{0,1}[0-9]{2}');

  @override
  void initState() {
    /*
     # this methode have to be called at the initState to be sure that the bluetooth is activated
     # before using corresponding methode 
        checkBluetooth();
     */
    MainPageProvider().resetProvider();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myScrollController.dispose();
    _streamController.done;
  }

  //This methode is responsible for displayiing an animations when the icon in
  //the sliverAppBar is clicked.
  void listviewAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myScrollController.animateTo(MediaQuery.of(context).size.height,
          duration: Duration(seconds: 1), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    ConfigSize().init(context);
    //the Widget "ChangeNotifierProvider" allow each of its children to access to the Provider
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
                    expandedHeight: ConfigSize.blockSizeVertical * 15,
                    backgroundColor: Colors.white,
                    pinned: true,
                    actions: <Widget>[
                      IconButton(
                        iconSize: ConfigSize.blockSizeVertical * 5,
                        color: Colors.blueGrey,
                        icon: Icon(Icons.device_unknown),
                        onPressed: () {
                          listviewAnimation();
                        },
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: FadeOnScroll(
                        scrollController: myScrollController,
                        fullOpacityOffset: 120,
                        child: Text(
                          "Appairage Bluetooth",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: ConfigSize.blockSizeVertical * 4,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Open Sans'),
                        ),
                      ),
                      background: Image.asset('assets/images/BENALU.png',
                          alignment: Alignment.centerLeft),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding:
                    EdgeInsets.only(bottom: ConfigSize.blockSizeVertical * 4),
                child: StreamBuilder<List<BluetoothDevice>>(
                    //The stream come from "bluetoothStartScan()" methode.
                    stream: _streamController.stream,
                    initialData: [],
                    builder: (BuildContext context,
                        AsyncSnapshot<List<BluetoothDevice>> snapshot) {
                      //in this widget we get back the devices list, previouly sended by
                      //the streamController.
                      return !snapshot.hasData
                          ? Container()
                          : ListView.builder(
                              itemCount: 15, //snapshot.data.length,
                              itemBuilder: (context, index) {
                                return MainPageTile(
                                  text: "WH - 00$index - TH",
                                  device: null,
                                  flutterBlue: null,
                                  index: index,
                                );
                                //replace the Widget above by the one underneath when you use bluetooth
                                /*return MainPageTile( 
                                  text: snapshot.data[index].name, 
                                  device: snapshot.data[index], 
                                  flutterBlue: flutterBlue, 
                                    );*/
                              },
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
    //This methode is responsible for checking if the bluetooth parameter is enable.
    //If not, the user is redirected to the parameter to activate the bluetooth.
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
    //This methode is use to go to the phone parameter fo bluetooth
    SystemSetting.goto(SettingTarget.BLUETOOTH);
  }

  void bluetoothStartScan() {
    //This methode use the instance of the Flutter_Blue class to scan
    //nerby devices. 
    deviceList.clear();
    flutterBlue.scan(timeout: Duration(seconds: 5)).listen((scanResult) {
      if (deviceList.indexOf(scanResult.device) == -1) {
        /*PARAMETRE USER ONLY : scan filter */
        /*if(immatriculationRegExp.hasMatch(scanResult.device.name)){
          deviceList.add(scanResult.device);
        }*/
        deviceList.add(scanResult.device);
      }
      //When the devices are loaded in the deviceList, we send it via StreamController
      //and get it back in the streamBuilder (see listView upper)
      _streamController.sink.add(deviceList);
    }, onDone: (() {
      print("Stream done");
      _streamController.close();
      _streamController =
          new StreamController<List<BluetoothDevice>>.broadcast();
    }));
  }*/
}
