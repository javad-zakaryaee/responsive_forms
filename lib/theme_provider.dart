import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData appTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.light,
  );
  bool isDark = false;

  void changeThemeColor() {
    final darkTheme = ThemeData(
        primarySwatch: Colors.deepPurple,
        focusColor: Color(0xff5F5AF6),
        scaffoldBackgroundColor: Color(0xff192132),
        brightness: Brightness.dark,
        cardColor: Color(0xff26334D),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.white54),
            headline6:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w600)));

    final lightTheme = ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xffF8FAFC),
        cardColor: Colors.white);
    !isDark ? appTheme = darkTheme : appTheme = lightTheme;
    isDark = !isDark;
    notifyListeners();
  }
}
