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
 
class _MainPageState extends State<MainPage> { 
  FlutterBlue flutterBlue = FlutterBlue.instance; 
  StreamController<List<BluetoothDevice>> _streamController = 
      StreamController<List<BluetoothDevice>>.broadcast(); 
  static final List<BluetoothDevice> deviceList = new List<BluetoothDevice>();
  Key listviewKey = UniqueKey();
  @override 
  void initState() { 
    //checkBluetooth(); 
    super.initState(); 
  } 
 
  @override 
  void dispose() {  
    super.dispose(); 
  } 

  void restartKey(){
    setState(() {
      listviewKey = UniqueKey();
    });
  }
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar( 
        leading: IconButton(icon: Icon(Icons.refresh), onPressed:null),
        centerTitle: true, 
        backgroundColor: Colors.red[900], 
        title: Text( 
          "Appairage Bluetooth", 
          textScaleFactor: 1.3, 
        ), 
      ), 
      body: Column( 
        children: <Widget>[ 
          Padding( 
            padding: const EdgeInsets.all(10.0), 
            child: StreamBuilder( 
              stream: _streamController.stream, 
              builder: (BuildContext context, AsyncSnapshot snapshot) { 
                switch (snapshot.connectionState) { 
                  case ConnectionState.none: 
                    return Text("Erreur de connection"); 
                  case ConnectionState.done: 
                  case ConnectionState.waiting: 
                    return Column(children: <Widget>[ 
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
                      Text("Appuyer pour rafraichir", 
                          style: TextStyle(color: Colors.grey[700])), 
                    ]); 
                    break; 
                  case ConnectionState.active: 
                    return SpinKitRing(color: Colors.green[300]); 
                    break; 
                } 
              }, 
            ), 
          ), 
          new Flexible( 
            child: StreamBuilder<List<BluetoothDevice>>( 
                stream: _streamController.stream, 
                builder: (BuildContext context, AsyncSnapshot<List<BluetoothDevice>> snapshot) {
                      if(!snapshot.hasData){print("there is no data incommming yet");}
                      else{print("there is data incomming");}
                  return !snapshot.hasData 
                      ? Container() 
                      : ListView.builder( 
                        key: listviewKey,
                          itemCount: snapshot.data.length, 
                          itemBuilder: (context, index) { 
                            return MainPageTile( 
                              text: snapshot.data[index].name, 
                              device: snapshot.data[index], 
                            ); 
                          }, 
                        );
                }), 
          ), 
        ], 
      ), 
      bottomNavigationBar: Padding( 
        padding: const EdgeInsets.all(8.0), 
        child: Text( 
          "Sélectionner une benne sur laquelle vous connecter", 
          textScaleFactor: 1.5, 
          textAlign: TextAlign.center, 
          style: TextStyle(color: Colors.grey[700]), 
        ), 
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
    flutterBlue.scan(timeout: Duration(seconds: 5)).listen((scanResult) { 
      if (deviceList.indexOf(scanResult.device) == -1) { 
        deviceList.add(scanResult.device); 
      } 
      _streamController.sink.add(deviceList); 
    }, onDone: (() { 
      print("Stream done"); 
      _streamController.close();
      _streamController = new
      StreamController<List<BluetoothDevice>>.broadcast();
    })); 
  } 
}