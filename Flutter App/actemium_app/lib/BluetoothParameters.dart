import 'package:flutter_blue/flutter_blue.dart';

class BluetoothParameters {
  final BluetoothDevice device;
  List<BluetoothService> services;
  
  BluetoothParameters(
    this.device,
  );

  void setServices()async{
    this.services = await this.device.discoverServices();
  }

  List<BluetoothCharacteristic> getCharacteristicFromService(BluetoothService _service){
    var index = this.services.indexOf(_service);
    return this.services[index].characteristics;
  }

}