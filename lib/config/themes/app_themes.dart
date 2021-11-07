import 'dart:ui';

import 'package:cryptoexpo/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyColors {
  MyColors._();
  static const Color whyte = Color.fromRGBO(252, 252, 252, 1);
  static const Color sweetWhite = Color.fromRGBO(250, 250, 250, 1);
  static const Color fadedWhite = Color(0xFFF7F9FC);
  static const Color mintCream = Color.fromRGBO(239, 247, 246, 1);
  static const Color ivory = Color.fromRGBO(251, 255, 241, 1);
  static const Color papayaWhip = Color.fromRGBO(249, 236, 204, 1);
  static const Color janquil = Color.fromRGBO(241, 196, 15, 1);
  static const Color lightSteelBlue = Color.fromRGBO(180, 197, 228, 1);
  static const Color babyBlue = Color.fromRGBO(108, 212, 255, 1);
  static const Color blueYonder = Color.fromRGBO(96, 113, 150, 1);
  static const Color starCommandBlue = Color.fromRGBO(34, 116, 165, 1);
  static const Color trueBlue = Color.fromRGBO(48, 102, 190, 1);
  static const Color caribbeanGreen = Color.fromRGBO(6, 214, 160, 1);
  static const Color emerald = Color.fromRGBO(0, 204, 102, 0.2);
  static const Color flame = Color.fromRGBO(235, 94, 40, 0.2);
  static const Color orangePantone = Color.fromRGBO(247, 92, 3, 1);
  static const Color roseMadder = Color.fromRGBO(223, 41, 53, 0.2);
  static const Color deepChestnut = Color.fromRGBO(188, 71, 73, 1);
  static const Color internationalOrange = Color.fromRGBO(187, 52, 47, 1);
  static const Color purpleMunsell = Color.fromRGBO(177, 24, 200, 1);
  static const Color spanishGray = Color.fromRGBO(149, 150, 157, 1);
  static const Color xiketic = Color.fromRGBO(2, 1, 10, 1);
  static const Color spaceCadet = Color.fromRGBO(44, 42, 74, 1);
  static const Color richBlack = Color.fromRGBO(8, 7, 8, 1);
}

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
  static Color mustard = Colors.amber;

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
  static const Color _lightPrimaryColor = MyColors.whyte;

  //Background Colors
  static const Color _lightBackgroundColor = _lightPrimaryColor;
  static const Color _lightBackgroundAppBarColor = _lightPrimaryColor;
  static const Color _lightBackgroundSecondaryColor = white;
  static const Color _lightBackgroundAlertColor = blackPearl;
  static const Color _lightBackgroundActionTextColor = white;
  static const Color _lightDividerColor = Color(0x11000000);

  //Text Colors
  static const Color _lightTextColor = Colors.black;

  //Border Color
  static const Color _lightBorderColor = nevada;

  //Icon Color
  static const Color _lightIconColor = ebonyClay;
  static Color _lightBottomNavigationBarUnselectedIconColor = nevada;
  static Color _lightBottomNavigationBarSelectedIconColor = mustard;

  //form input colors
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
  static const Color _darkPrimaryColor = MyColors.richBlack;

  //Background Colors
  static const Color _darkBackgroundColor = _darkPrimaryColor;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor = Color.fromRGBO(0, 0, 0, .6);
  static const Color _darkBackgroundAlertColor = blackPearl;
  static const Color _darkBackgroundActionTextColor = white;
  static const Color _darkDividerColor = Colors.white12;

  //Text Colors
  static const Color _darkTextColor = Colors.white;

  //Border Color
  static const Color _darkBorderColor = nevada;

  //Icon Color
  static const Color _darkIconColor = whiteLilac;
  static Color _darkBottomNavigationBarUnselectedLabelColor = nevada;
  static Color _darkBottomNavigationBarSelectedLabelColor = mustard;

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  //text theme for light theme
  static final TextTheme _lightTextTheme = GoogleFonts.barlowTextTheme(TextTheme(
    headline1: TextStyle(fontSize: 40.0, color: _lightColorScheme.onPrimary),
    headline2: TextStyle(fontSize: 32.0, color: _lightColorScheme.onPrimary),
    headline3: TextStyle(fontSize: 28.0, color: _lightColorScheme.onPrimary),
    headline4: TextStyle(fontSize: 24.0, color: _lightColorScheme.onPrimary),
    headline5: TextStyle(fontSize: 20.0, color: _lightColorScheme.onPrimary),
    headline6: TextStyle(fontSize: 16.0, color: _lightColorScheme.onPrimary),
    bodyText1: TextStyle(fontSize: 16.0, color: _lightColorScheme.onPrimary),
    bodyText2: TextStyle(fontSize: 14.0, color: _lightColorScheme.onPrimary),
    button: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600,
      color: MyColors.trueBlue
    ),
    subtitle1: TextStyle(fontSize: 16.0, color: _lightTextColor),
    caption: TextStyle(fontSize: 11.0, color: _lightColorScheme.onPrimary),
  ));

  static final ColorScheme _lightColorScheme = ColorScheme.light().copyWith(
    primary: MyColors.whyte,
    onPrimary: MyColors.xiketic,
    // primaryVariant: null,
    secondary: Colors.blueAccent,
    onSecondary: MyColors.xiketic,
    secondaryVariant: MyColors.spanishGray,
    // error: null,
    // onError: null,
    // surface: null,
    // onSurface: MyColors.spanishGray,
    background: MyColors.fadedWhite,
    onBackground: MyColors.spanishGray,
    // brightness: null,
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    primaryTextTheme: _lightTextTheme,
    colorScheme: _lightColorScheme,
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
      foregroundColor: _lightTextColor,
      backgroundColor: _lightBackgroundAppBarColor,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightTextColor),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: _lightBackgroundAlertColor,
        actionTextColor: _lightBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: _lightColorScheme.secondary,
      unselectedItemColor: _lightColorScheme.secondaryVariant,
      selectedLabelStyle: _lightTextTheme.caption!.copyWith(
        height: 1.5
      ),
      unselectedLabelStyle: _lightTextTheme.caption!.copyWith(
          height: 1.5
      ),
      backgroundColor: _lightColorScheme.background,
      elevation: 0
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: _lightTextTheme.bodyText2?.copyWith(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(0.2, 0.2),
              blurRadius: 0.1,
              color: _lightColorScheme.onPrimary,
            )
          ]
      ),
      unselectedLabelStyle: _lightTextTheme.bodyText2!.copyWith(
        color: _lightColorScheme.onBackground,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightBackgroundAppBarColor),
    textTheme: _lightTextTheme,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        )
    ),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _lightPrimaryColor,
        textTheme: ButtonTextTheme.primary,
        // colorScheme: _lightColorScheme
    ),
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

  static final TextTheme _darkTextTheme = GoogleFonts.barlowTextTheme(TextTheme(
    headline1: TextStyle(fontSize: 40.0, color: _darkColorScheme.onPrimary),
    headline2: TextStyle(fontSize: 32.0, color: _darkColorScheme.onPrimary),
    headline3: TextStyle(fontSize: 28.0, color: _darkColorScheme.onPrimary),
    headline4: TextStyle(fontSize: 24.0, color: _darkColorScheme.onPrimary),
    headline5: TextStyle(fontSize: 20.0, color: _darkColorScheme.onPrimary),
    headline6: TextStyle(fontSize: 16.0, color: _darkColorScheme.onPrimary),
    bodyText1: TextStyle(fontSize: 16.0, color: _darkColorScheme.onPrimary),
    bodyText2: TextStyle(fontSize: 14.0, color: _darkColorScheme.onPrimary),
    button: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600,
        color: MyColors.purpleMunsell
    ),
    subtitle1: TextStyle(fontSize: 16.0, color: _darkTextColor),
    caption: TextStyle(fontSize: 11.0, color: _darkColorScheme.onBackground),
  ));

  static final ColorScheme _darkColorScheme = ColorScheme.dark().copyWith(
    primary: MyColors.richBlack,
    onPrimary: MyColors.ivory,
    // primaryVariant: null,
    background: MyColors.xiketic,
    secondary: MyColors.purpleMunsell,
    onSecondary: MyColors.whyte,
    secondaryVariant: MyColors.spanishGray,
    // error: null,
    // onError: null,
    // surface: null,
    onSurface: MyColors.whyte,
    onBackground: MyColors.spanishGray,
    // brightness: null,
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    primaryTextTheme: _darkTextTheme,
    colorScheme: _darkColorScheme,
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
      iconTheme: IconThemeData(color: _darkTextColor),
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: _darkBackgroundAlertColor,
        actionTextColor: _darkBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _darkIconColor, //_darkIconColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: _darkColorScheme.secondary,
        unselectedItemColor: _darkColorScheme.secondaryVariant,
        selectedLabelStyle: _darkTextTheme.caption!.copyWith(
            height: 1.5,
        ),
        unselectedLabelStyle: _darkTextTheme.caption!.copyWith(
            height: 1.5,
        ),
        backgroundColor: _darkColorScheme.background,
        elevation: 0
    ),
    tabBarTheme: TabBarTheme(
        labelStyle: _darkTextTheme.bodyText2?.copyWith(
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.2, 0.2),
                blurRadius: 0.1,
                color: _darkColorScheme.onPrimary,
              )
            ]
        ),
        unselectedLabelStyle: _darkTextTheme.bodyText2!.copyWith(
          color: _darkColorScheme.onBackground
        ),
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkBackgroundAppBarColor),
    textTheme: _darkTextTheme,
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(MyColors.purpleMunsell),
        )
    ),
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
