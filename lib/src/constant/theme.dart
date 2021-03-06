import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemePrimary {
  static Color primaryColor = const Color(0xFF279E97);
  static Color scaffoldBackgroundColor = const Color(0xFFF5F5F5);
  static Color textPrimaryColor = const Color(0xFF1C1B1B);

  static Color backgroundColor = const Color(0xFFFFFFFF);

  static Color green = const Color(0xFF4CD97B);
  static Color orange = const Color(0xFFFFB259);

  static Color red = const Color(0xFFFF0000);

  static List<BoxShadow> boxShadow = [
    const BoxShadow(
      color: Colors.black26,
      blurRadius: 7,
      offset: Offset(0, 3),
    )
  ];
}
