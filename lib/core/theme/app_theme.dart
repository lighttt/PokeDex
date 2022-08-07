import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.blue,
        ));
  }
}
