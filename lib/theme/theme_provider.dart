import 'package:flutter/material.dart';
import 'package:chatapp/theme/light_mode.dart';
import 'dark_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;

  bool get isDarkmode => _themeData == darkmode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggletheme (){
    if(_themeData == lightmode){
      themeData = darkmode;

    }else{
      themeData = lightmode;
    }
  }
}


// ThemeData themeData = lightmode;
//
// bool isDarkMode (){
//   return themeData ==darkmode;
// }
//
//
//
// void toggletheme (){
//   if(themeData == lightmode){
//     {
//       themeData = darkmode;
//       notifyListeners();
//     }
//
//   }else{
//     themeData = lightmode;
//     notifyListeners();
//   }
// }
// }