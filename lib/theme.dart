import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppTheme{
  static ThemeData appTheme(bool isDark,BuildContext context){
    return ThemeData(
      brightness: isDark ? Brightness.dark:Brightness.light,
          appBarTheme: AppBarTheme(
        backgroundColor: isDark ?const Color(0xff181818):Colors.deepPurple
    ),
    colorScheme: isDark ? const ColorScheme.dark(
      onSecondary: Colors.white,
    ): const ColorScheme.light(onSecondary: Colors.white),
      floatingActionButtonTheme:  const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepPurpleAccent,
      )
    );
  }
}

class ThemeNotifier with ChangeNotifier{
  late bool _isDark;
  bool get isDark => _isDark;
  ThemeNotifier(){
    _isDark = false;
    loadFromStorage();
    notifyListeners();
  }

  void toggleTheme(bool value){
    _isDark =value;
    notifyListeners();
    saveToStorage();
  }
  Future<bool> loadFromStorage()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDark = preferences.getBool('isDark')?? false;
    notifyListeners();
    return _isDark;
  }

  saveToStorage()async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isDark', _isDark);
  }
}