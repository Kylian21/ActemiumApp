import 'package:flutter_blue/flutter_blue.dart';

class BluetoothParameters {

  List<BluetoothCharacteristic> getCharacteristicsFromService(BluetoothDevice _device,Guid serviceUuiD){
     _device.discoverServices().then((_list){
      List<BluetoothService> tmp = _list.where((s)=>s.uuid==serviceUuiD);
      return tmp[0].characteristics;
    });
    return null;
  }

}