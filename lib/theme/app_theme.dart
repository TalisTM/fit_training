import 'package:flutter/material.dart';

var primaryColorApp = const Color(0xFFFD7014);
var backgroundDark = const Color(0xFF222831);
var darkColor = const Color(0xFF393E46);
var white = const Color(0xFFFFFFFF);
var grey = const Color(0xFF404040);
var lightGrey = const Color(0xFFcccccc);

class AppTheme {

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColorApp,
    backgroundColor: white,
    splashColor: white,
    hintColor: lightGrey,
    cardColor: grey,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: primaryColorApp,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: primaryColorApp
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontWeight: FontWeight.w700,
        color: primaryColorApp,
        fontSize: 40 
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.w600, 
        color: Colors.grey[700],
        fontSize: 16 
      ),
      headline3: TextStyle(
        color: white, 
        fontSize: 20,
        fontWeight: FontWeight.w700
      ),
      headline4: TextStyle(
        color: white, 
        fontSize: 20,
        fontWeight: FontWeight.w400
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.w600,
        color: primaryColorApp,
        fontSize: 26 
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        color: primaryColorApp,
        fontSize: 24 
      ),
      subtitle1: const TextStyle(
        fontSize: 20
      ),
      subtitle2: TextStyle(
        fontSize: 18,
        color: primaryColorApp,
        fontWeight: FontWeight.w500
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.w600, 
        color: Colors.grey[700],
        fontSize: 26 
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w600, 
        color: Colors.grey[600],
        fontSize: 18 
      ),
      button: TextStyle(
        color: white,
        fontSize: 22
      )
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColorApp,
    backgroundColor: backgroundDark,
    hintColor: backgroundDark,
    cardColor: lightGrey,
    splashColor: darkColor,
    scaffoldBackgroundColor: backgroundDark,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: primaryColorApp,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: primaryColorApp
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontWeight: FontWeight.w700,
        color: primaryColorApp,
        fontSize: 40 
      ),
      headline2: TextStyle(
        fontWeight: FontWeight.w600, 
        color: lightGrey,
        fontSize: 16 
      ),
      headline3:  TextStyle(
        color: darkColor, 
        fontSize: 20,
        fontWeight: FontWeight.w700
      ),
      headline4: TextStyle(
        color: darkColor, 
        fontSize: 20,
        fontWeight: FontWeight.w400
      ),
      headline5: TextStyle(
        fontWeight: FontWeight.w600,
        color: primaryColorApp,
        fontSize: 26 
      ),
      headline6: TextStyle(
        fontWeight: FontWeight.w600,
        color: primaryColorApp,
        fontSize: 24 
      ),
      subtitle1: TextStyle(
        fontSize: 20,
        color: lightGrey
      ),
      subtitle2: TextStyle(
        fontSize: 18,
        color: primaryColorApp,
        fontWeight: FontWeight.w500
      ),
      bodyText1: TextStyle(
        fontWeight: FontWeight.w600, 
        color: Colors.grey[700],
        fontSize: 26 
      ),
      bodyText2: TextStyle(
        fontWeight: FontWeight.w600, 
        color: Colors.grey[400],
        fontSize: 18 
      ),
      button: TextStyle(
        color: darkColor,
        fontSize: 22
      )
    ),
    listTileTheme: ListTileThemeData(
      textColor: white,
      tileColor: darkColor,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: backgroundDark
    ),
    unselectedWidgetColor: lightGrey
  );
}