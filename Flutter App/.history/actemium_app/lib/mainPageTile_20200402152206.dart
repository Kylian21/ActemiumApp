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
  //Tuple2<Key,bool> _myCardInfo = new Tuple2(myKey,isSelected);

  MainPageTile({Key key, @required this.text, @required this.device, @required this.flutterBlue }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<MainPageProvider>(context);
    
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
          child: Padding(
        key: myKey,
        padding: const EdgeInsets.only(bottom: 5),
        child: InkWell(
          onTap: (){
            //when the card is selected we provide the key to the provider
            //which it will rebuild the cards and change the state of the
            //unamed one.
            provider.setcardState = myKey;
            //bluetoothConnect(context);
            },
          child: Card(
            elevation: 4,
            color:  provider.cardState == myKey 
                    ?Colors.grey[200] :Colors.grey[400],
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:5),
                  child: Icon(
                    Icons.airport_shuttle, 
                    color: provider.cardState == myKey 
                          ?Colors.grey[400] :Colors.black,
                    size: 60,),
                ),
                Expanded(
                    child: Text(
                  this.text,
                  style: TextStyle(
                    fontSize: 30,
                    color: provider.cardState == myKey 
                    ?Colors.grey[400]:Colors.black
                  ),
                  textAlign: TextAlign.center,
                ))
              ],
            ),
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
