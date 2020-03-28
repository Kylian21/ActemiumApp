import 'package:actemium_app/mainPageTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget{

  final listviewExample = List<String>.generate(
    5, 
    (i) => "AA 00${i+1} AA",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("Menu Principal"),
      ),
      body: Column(
        children: <Widget>[
          IconButton(
            icon : Icon(Icons.autorenew),
            iconSize: 60,
            color: Colors.green[300],
            onPressed: (){},
          ),
          Text("Appuyer pour rafaichir"),
          Flexible(
              child: ListView.builder(
              itemCount: listviewExample.length,
              itemBuilder: (context, index){
                return MainPageTile(text: listviewExample[index],);
              },
            ),
          ),
          Text("Sélectionner une benne sur laquelle vous connecter")
        ],
      ),
    );
  }
}