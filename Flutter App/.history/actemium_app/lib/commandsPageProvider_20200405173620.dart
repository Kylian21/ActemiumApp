import 'package:flutter/cupertino.dart';

class CommandsPageProvider with ChangeNotifier{

  int _page = 1;
  
  int get pageState => _page;

  set pageState(int newValue){
    _page = newValue;
    notifyListeners();
  }
}