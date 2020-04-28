import 'package:flutter/cupertino.dart';

class MainPageProvider with ChangeNotifier{

  //this provider allow the card in the mainpagetile class to
  //know if they are the chosen one, compare with the key
  //If the _cardKey is null : neither card is chosen, so they all in the same color
  //if the _cardKey is not null : a card is selected, this one is colored in bluegrey and the 
  //other ones are in grey.

  Key _cardKey;
  
  Key get cardState => _cardKey;

  set cardState(Key newValue){
    _cardKey = newValue;
    //When this methode is called, it will notify the listener through Consumer class or
    //Provider of context instance.
    notifyListeners();
  }
   void resetProvider() => _cardKey = null;
}