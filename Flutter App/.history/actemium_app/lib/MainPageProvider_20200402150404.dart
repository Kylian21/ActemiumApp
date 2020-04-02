import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class MainPageProvider with ChangeNotifier{

  Tuple2<Key,bool> _cardInfo = const Tuple2<Key,bool>(null,false);
  
  Tuple2<Key,bool> get cardState => _cardInfo;

  set cardState(Tuple2<Key,bool> newValue){
    _cardInfo = newValue;
    notifyListeners();
  }
}