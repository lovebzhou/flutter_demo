import 'package:flutter/material.dart';

class HBColors {
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color primaryColor = Color(0xFF218AEF);
  static const Color primaryHighlightColor = Color(0xAA218AEF);

  static const Color redNormal = Color(0xFFD32D2F);

  static const Color redHighLight = Color(0xEED32D2F);

  static const Color black1 = Color(0xFF333333);

  static const Color dividerColor = Color(0xFFE1E1E1);

  static const Color actionIconColor = Color(0xFFC7C7CD);

  static const Color iconColor = Color(0xFF8E8E93);

  static Color fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
