import 'package:flutter/material.dart';
import 'package:telegram/Themes/dark_mode.dart';
import 'package:telegram/Themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  // o'zgarishni saqlash
  set themeData(ThemeData themeData){
    _themeData = themeData;

    // o'zgarishni saqlovchi funksiya
    notifyListeners();
  }

  // o'zgartirmoq
  void toggle(){
    if(_themeData == lightMode){
      themeData = darkMode;
    } else{
      themeData = lightMode;
    }
  }
}