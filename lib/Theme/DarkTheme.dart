import 'package:flutter/material.dart';
import 'package:vpn_app/Utils/Colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: SpecialColors.textColorGray,
    primary: Colors.grey[900]!,
    secondary: Colors.grey[400]!,
  ),
);
