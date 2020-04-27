import 'package:actemium_app/EditPage/EditFormWidget.dart';
import 'package:actemium_app/ConfigSize.dart';
//import 'package:actemium_app/EditPage/EditTextfieldWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class EditPage extends StatefulWidget {
  final String name;
  final String deviceID;

  EditPage({Key key, @required this.name, @required this.deviceID})
      : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<GlobalKey<FormState>> formKeyList = new List<GlobalKey<FormState>>(5);
  List<int> formKeyListIndex = new List<int>(5);

  @override
  void initState() {
    super.initState();
    for(int i=0;i<5;i++){
      formKeyList[i]=new GlobalKey<FormState>();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {

    ConfigSize().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_down,
                size: ConfigSize.blockSizeHorizontal * 10, color: Colors.black),
            onPressed: () {
              List<bool> _list = new List<bool>();
              formKeyList.forEach((key) {
                key.currentState.validate();
                _list.add(key.currentState.validate());
                });
              if (_list.indexOf(false) == -1) {
                Navigator.of(context).pop();
              }
            }),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 2),
                      left: BorderSide(width: 2),
                      right: BorderSide(width: 2),
                      bottom: BorderSide(width: 1),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "MODULE BLUETOOTH :",
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 1),
                    left: BorderSide(width: 2),
                    right: BorderSide(width: 2),
                    bottom: BorderSide(width: 2),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("${widget.deviceID}",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 20)),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: EditFormWidget(
                      text: "NOM MODULE",
                      formKey: formKeyList[0],
                      formKeyIndex: 0,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: EditFormWidget(
                      text: "MOT DE PASSE",
                      formKey: formKeyList[1],
                      formKeyIndex: 1,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 2),
                      right: BorderSide(width: 2),
                      left: BorderSide(width: 2),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "SEUIL D'INTENSITE :",
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: EditFormWidget(
                      text: "BACHAGE",
                      formKey: formKeyList[2],
                      formKeyIndex: 2,
                    )),
                    Expanded(
                      child: EditFormWidget(
                        text: "DEBACHAGE",
                        formKey: formKeyList[3],
                        formKeyIndex: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: EditFormWidget(
                    text: "SENSIBILITE D'ALERTE",
                    formKey: formKeyList[4],
                    formKeyIndex: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
