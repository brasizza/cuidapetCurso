import 'package:flutter/material.dart';

class ThemeUtils {

  static Color primaryColor;
  static Color primaryColorDark;
  static Color primaryColorLight;
  static Color accentColor;
  static ThemeData theme;


  static void int(BuildContext context){
    theme = Theme.of(context);
    primaryColor = theme.primaryColor;
    primaryColorDark = theme.primaryColorDark;
    accentColor = theme.accentColor;
    primaryColorLight = theme.primaryColorLight;
  }
}