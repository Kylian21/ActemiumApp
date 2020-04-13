import 'package:flutter/cupertino.dart';

class MainPageProvider with ChangeNotifier{

  Key _cardKey;
  
  Key get cardState => _cardKey;

  set cardState(Key newValue){
    _cardKey = newValue;
    notifyListeners();
  }
   void resetProvider() => _cardKey = null;
}