import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{
  int _selectedMenuOpt = 0;


  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt( int i ){
    this._selectedMenuOpt = i;
    notifyListeners(); //notifica a todo lo que este escuchando que se ha efectuado un cambio
  }
}

