import 'package:flutter/material.dart';
import 'colors.dart';

///文本样式
class HBTextStyle {
  static const fontSize17 = 17.0;
  static const fontSize24 = 24.0;

  static const middleRedText =
      TextStyle(color: HBColors.primaryColor, fontSize: fontSize17);

  static const largeText1 = TextStyle(
      color: HBColors.black1,
      fontSize: fontSize24,
      fontWeight: FontWeight.bold);

  static const buttonTextStyle1 =
      TextStyle(color: Colors.white, fontSize: 14.0);
}
