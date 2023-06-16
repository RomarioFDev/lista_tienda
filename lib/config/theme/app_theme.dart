import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData appTheme = ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ));
}
