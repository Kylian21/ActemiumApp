import 'package:flutter/cupertino.dart';

class MainPageProvider with ChangeNotifier{

  Key _cardKey;
  
  Key get cardState => _cardKey;

  set setcardState(Key newValue){
    _cardKey = newValue;
    notifyListeners();
  }
}