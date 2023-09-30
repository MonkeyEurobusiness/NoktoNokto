import 'package:flutter/material.dart';
import 'package:noktonokto/pages/login.dart';
import 'package:noktonokto/pages/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
            primary: Color(0xFFD4A373),
            onPrimary: Colors.black,
            brightness: Brightness.light,
            secondary: Color(0xFFCCD5AE),
            onSecondary: Colors.black,
            tertiary: Color(0xFFFEFAE0),
            onTertiary: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color: Color(0xFFFAEDCD))
      ),
      home: const LoginPage(),
    );
  }
}
