import 'package:actemium_app/deviceServicesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class MainPageTile extends StatelessWidget {
  final String text;
  final BluetoothDevice device;
  final FlutterBlue flutterBlue;
  final TextStyle mystyle = new TextStyle(
    fontSize: 30,
  );
  bool isSelected = true;

  MainPageTile({Key key, @required this.text, @required this.device, @required this.flutterBlue }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: (){
          isSelected = true;
          //bluetoothConnect(context);
          },
        child: Card(
          elevation: 4,
          color: isSelected ?Colors.grey[200] :Colors.grey[400],
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:5),
                child: Icon(
                  Icons.airport_shuttle, 
                  color: isSelected ?Colors.grey[400] :Colors.black,
                  size: 60,),
              ),
              Expanded(
                  child: Text(
                this.text,
                style: mystyle,
                textAlign: TextAlign.center,
              ))
            ],
          ),
        ),
      ),
    );
  }


  void bluetoothConnect(BuildContext context)async{
    try{
      await device.connect();
      print("Connection established with device {${device.name}}");
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DeviceServicesPage(device: device)));
    }
    catch (e){
      if(e.code != "alreadyConnected"){
        throw e;
      }
    }
  }
}
