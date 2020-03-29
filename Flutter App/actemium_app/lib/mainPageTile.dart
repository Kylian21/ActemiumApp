import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class MainPageTile extends StatelessWidget {
  final String text;
  final BluetoothDevice device;
  final TextStyle mystyle = new TextStyle(
    fontSize: 40,
  );

  MainPageTile({Key key, @required this.text, @required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: (){bluetoothConnect();},
        child: Card(
          elevation: 4,
          color: Colors.grey[400],
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:5),
                child: Icon(Icons.airport_shuttle, size: 60,),
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
  void bluetoothConnect() async{
    try{
      await device.connect();
    }
    catch (e){
      if(e.code != "alreadyConnected"){
        throw e;
      }
    }
    
  }
}
