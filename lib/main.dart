import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/upload/upload_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Brain',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const UploadScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
