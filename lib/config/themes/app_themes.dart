import 'dart:ui';

import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppThemes {
  AppThemes._();

  static const Color dodgerBlue = Color.fromRGBO(29, 161, 242, 1);
  static const Color whiteLilac = Color.fromRGBO(248, 250, 252, 1);
  static const Color blackPearl = Color.fromRGBO(22, 24, 32, 1);
  static const Color brinkPink = Color.fromRGBO(255, 97, 136, 1);
  static const Color juneBud = Color.fromRGBO(186, 215, 97, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color sweetWhite = Color.fromRGBO(250, 250, 250, 1);
  static const Color nevada = Color.fromRGBO(105, 109, 119, 1);
  static const Color ebonyClay = Color.fromRGBO(40, 42, 58, 1);
  static const Color blackRoot = Color.fromRGBO(10, 13, 16, 1);
  static Color ashley = HexColor('#9297A4');
  static const Color mustard = Colors.amber;

  static String font1 = "ProductSans";
  static String font2 = "Roboto";


// Light theme

  //SystemUiOverlayStyle
  static lightSystemUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _lightPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  //constants color range for light theme

  //main color
  static const Color _lightPrimaryColor = sweetWhite;

  //Background Colors
  static const Color _lightBackgroundColor = _lightPrimaryColor;
  static const Color _lightBackgroundAppBarColor = _lightPrimaryColor;
  static const Color _lightBackgroundSecondaryColor = white;
  static const Color _lightBackgroundAlertColor = blackPearl;
  static const Color _lightBackgroundActionTextColor = white;
  static const Color _lightAppBarShadowColor = whiteLilac;
  static const Color _lightBackgroundErrorColor = brinkPink;
  static const Color _lightBackgroundSuccessColor = juneBud;
  static const Color _lightBottomNavigationBarBackgroundColor = _lightPrimaryColor;
  static const Color _lightDividerColor = Color(0x11000000);

  //Text Colors
  static const Color _lightTextColor = Colors.black;
  static const Color _lightAlertTextColor = Colors.black;
  static const Color _lightTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _lightBorderColor = nevada;

  //Icon Color
  static const Color _lightIconColor = ebonyClay;
  static Color _lightBottomNavigationBarUnselectedIconColor = ashley;
  static const Color _lightBottomNavigationBarSelectedIconColor = mustard;

  //form input colors
  static const Color _lightInputFillColor = _lightBackgroundSecondaryColor;
  static const Color _lightBorderActiveColor = _lightPrimaryColor;
  static const Color _lightBorderErrorColor = brinkPink;


// Dark theme

  //SystemUiOverlayStyle
  static darkSystemUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _darkPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    ));
  }

  //constants color range for dark theme
  static const Color _darkPrimaryColor = blackRoot;

  //Background Colors
  static const Color _darkBackgroundColor = _darkPrimaryColor;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor = Color.fromRGBO(0, 0, 0, .6);
  static const Color _darkBackgroundAlertColor = blackPearl;
  static const Color _darkBackgroundActionTextColor = white;
  static const Color _darkAppBarShadowColor = ebonyClay;
  static const Color _darkBackgroundErrorColor = Color.fromRGBO(255, 97, 136, 1);
  static const Color _darkBackgroundSuccessColor = Color.fromRGBO(186, 215, 97, 1);
  static const Color _darkBottomNavigationBarBackgroundColor = _darkPrimaryColor;
  static const Color _darkDividerColor = Colors.white12;

  //Text Colors
  static const Color _darkTextColor = Colors.white;
  static const Color _darkAlertTextColor = Colors.black;
  static const Color _darkTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _darkBorderColor = nevada;

  //Icon Color
  static const Color _darkIconColor = whiteLilac;
  static Color _darkBottomNavigationBarUnselectedLabelColor = ashley;
  static Color _darkBottomNavigationBarSelectedLabelColor = mustard;

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  //text theme for light theme
  static final TextTheme _lightTextTheme = TextTheme(
    headline1: TextStyle(fontSize: 20.0, color: _lightTextColor),
    bodyText1: TextStyle(fontSize: 16.0, color: _lightTextColor),
    bodyText2: TextStyle(fontSize: 14.0, color: Colors.grey),
    button: TextStyle(
        fontSize: 15.0, color: _lightTextColor, fontWeight: FontWeight.w600),
    headline6: TextStyle(fontSize: 16.0, color: _lightTextColor),
    subtitle1: TextStyle(fontSize: 16.0, color: _lightTextColor),
    caption: TextStyle(fontSize: 12.0, color: _lightBackgroundAppBarColor),
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    primaryColor: _lightBackgroundColor,
    // brightness: Brightness.dark,
    // primaryColorBrightness: Brightness.dark,
    fontFamily: font1,
    scaffoldBackgroundColor: _lightBackgroundColor,
    dividerTheme: DividerThemeData(
        color: _lightDividerColor,
        thickness: 0.5,
        space: 0
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: _lightTextColor),
      toolbarTextStyle: TextStyle(color: _lightTextColor),
      backgroundColor: _lightBackgroundAppBarColor,
      elevation: 0,
      // shadowColor: _lightAppBarShadowColor,
      iconTheme: IconThemeData(color: _lightTextColor),
    ),
    colorScheme: ColorScheme.light(),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: _lightBackgroundAlertColor,
        actionTextColor: _lightBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: _lightBottomNavigationBarSelectedIconColor,
      unselectedItemColor: _lightBottomNavigationBarUnselectedIconColor,
      backgroundColor: _lightPrimaryColor,
      elevation: 0
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightBackgroundAppBarColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _lightPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      //prefixStyle: TextStyle(color: _lightIconColor),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _lightBackgroundSecondaryColor,
      //focusColor: _lightBorderActiveColor,
    ),
  );

//text theme for dark theme
  /*static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
  static final TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _darkTextColor, fontWeight: FontWeight.w500);
  static final TextStyle _darkScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0,
      color: _darkBackgroundAppBarColor,
      fontWeight: FontWeight.w100);*/

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: TextStyle(fontSize: 20.0, color: _darkTextColor),
    bodyText1: TextStyle(fontSize: 16.0, color: _darkTextColor),
    bodyText2: TextStyle(fontSize: 14.0, color: Colors.grey),
    button: TextStyle(
        fontSize: 15.0, color: _darkTextColor, fontWeight: FontWeight.w600),
    headline6: TextStyle(fontSize: 16.0, color: _darkTextColor),
    subtitle1: TextStyle(fontSize: 16.0, color: _darkTextColor),
    caption: TextStyle(fontSize: 12.0, color: _darkBackgroundAppBarColor),
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    primaryColor: _darkBackgroundColor,
    brightness: Brightness.dark,
    //primarySwatch: _darkPrimaryColor, //cant be Color on MaterialColor so it can compute different shades.
    // accentColor: _darkPrimaryColor, //prefix icon color form input on focus

    fontFamily: font1,
    scaffoldBackgroundColor: _darkBackgroundColor,
    dividerColor: Colors.white12,
    dividerTheme: DividerThemeData(
      color: _darkDividerColor,
      thickness: 0.7,
      space: 0
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: _darkBackgroundAppBarColor,
      elevation: 0,
      // shadowColor: _darkAppBarShadowColor,
      // color: _darkBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _darkTextColor),
      textTheme: _darkTextTheme,
    ),
    colorScheme: ColorScheme.dark(
      // primary: _darkPrimaryColor,
      // primaryVariant: _darkBackgroundColor,

      // secondary: _darkSecondaryColor,
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: _darkBackgroundAlertColor,
        actionTextColor: _darkBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _darkIconColor, //_darkIconColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _darkBottomNavigationBarSelectedLabelColor,
        unselectedItemColor: _darkBottomNavigationBarUnselectedLabelColor,
        backgroundColor: blackPearl,
      elevation: 0
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkBackgroundAppBarColor),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _darkPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: TextStyle(color: _darkIconColor),
      //labelStyle: TextStyle(color: nevada),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _darkInputFillColor,
      //focusColor: _darkBorderActiveColor,
    ),
  );
}
