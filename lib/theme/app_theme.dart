import 'package:flutter/material.dart';

class AppTheme {

  var primaryColorApp = const Color(0xFFFF8C00);

  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFFF8C00),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFFFF8C00),
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Color(0xFFFF8C00)
      ),
    ),
    textTheme: TextTheme(
      headline1: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Color(0xFFFF8C00),
        fontSize: 40 
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.w600, 
        color: Colors.grey[700],
        fontSize: 16 
      ),
      headline3: const TextStyle(
        color: Colors.white, 
        fontSize: 20,
        fontWeight: FontWeight.w700
      ),
      headline4: const TextStyle(
        color: Colors.white, 
        fontSize: 20,
        fontWeight: FontWeight.w400
      ),
      subtitle1: const TextStyle(
        fontSize: 20
      ),
      subtitle2: const TextStyle(
        fontSize: 18,
        color: Color(0xFFFF8C00),
        fontWeight: FontWeight.w500
      )
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFFFF8C00)
  );
}