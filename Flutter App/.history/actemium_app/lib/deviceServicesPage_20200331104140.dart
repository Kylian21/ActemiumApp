import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceServicesPage extends StatelessWidget {
  final BluetoothDevice device;

  DeviceServicesPage({Key key, @required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(device.name),
        ),
        body: StreamBuilder<List<BluetoothService>>(
          stream: device.services,
          initialData: [],
          builder: ((BuildContext context,
              AsyncSnapshot<List<BluetoothService>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data[index].toString());
                });
          }),
        ));
  }
}
