import 'package:flutter/material.dart';
import 'colors.dart';

const int ThemeColor = 0xFFC91B3A;

class HBTheme extends Theme {
  static final mainThemeData = ThemeData(
    primaryColorBrightness: Brightness.light,
    // primarySwatch: Colors.lightBlue,
    primaryColor: HBColors.primaryColor,
    backgroundColor: HBColors.backgroundColor,
    dividerColor: HBColors.dividerColor,
    accentColor: Color(0xFFEFEFEF),
    splashColor: Colors.transparent, // 删除水波纹
    highlightColor: Colors.transparent, // 删除点击高亮

    appBarTheme: AppBarTheme(
      color: HBColors.fromHex("#F8F8F8"),
      elevation: 0.5,
      iconTheme: IconThemeData(
        color: HBColors.primaryColor,
      ),
      actionsIconTheme: IconThemeData(
        color: HBColors.primaryColor,
      ),
    ),

    iconTheme: IconThemeData(
      color: HBColors.primaryColor,
      size: 35.0,
    ),

    textTheme: TextTheme(
      body1: TextStyle(color: Color(0xFF333333), fontSize: 15.0),
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: HBColors.primaryColor,
      highlightColor: HBColors.primaryHighlightColor,
      splashColor: Colors.transparent,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: HBColors.primaryColor,
      labelStyle: TextStyle(fontSize: 10.0),
      unselectedLabelColor: HBColors.fromHex("#A2A2A2"),
      unselectedLabelStyle: TextStyle(fontSize: 10.0),
    ),
  );

  static final themeData2 = ThemeData(
    scaffoldBackgroundColor: HBColors.primaryColor,
    primarySwatch: Colors.blueGrey,
    backgroundColor: HBColors.primaryColor,
    appBarTheme: AppBarTheme(
      color: HBColors.primaryColor,
      elevation: 0.5,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
  );
}
