import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.indigo,
    secondary: Colors.indigoAccent,
    background: Colors.white,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.indigo,
    secondary: Colors.indigoAccent,
    background: Colors.black,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
);
