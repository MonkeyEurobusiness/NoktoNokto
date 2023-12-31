import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noktonokto/pages/camera.dart';
import 'pages/map.dart';
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
            secondary: Color(0xFFD4A373),
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
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: MapWidget(initialPosition: LatLng(50.06779728116886, 19.99146720652527),),
      home: LoginPage(),
    );
  }
}
