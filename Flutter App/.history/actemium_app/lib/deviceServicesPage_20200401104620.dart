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
        body: FutureBuilder<List<BluetoothService>>(
          future: device.discoverServices(),
          initialData: [],
          builder: ((BuildContext context,
              AsyncSnapshot<List<BluetoothService>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<BluetoothService> s = snapshot.data;
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: ,
                        child: Text(
                            '0x${s[index].uuid.toString().toUpperCase().substring(4, 8)}'));
                  });
            } else {
              return CircularProgressIndicator(
                backgroundColor: Colors.red,
              );
            }
          }),
        ));
  }
}
