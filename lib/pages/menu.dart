import 'package:flutter/material.dart';
import 'package:noktonokto/pages/camera.dart';
import 'package:noktonokto/pages/login.dart';

import 'map.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        onDestinationSelected: (int index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.camera_alt),
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Camera',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.chat),
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[const CameraPage(), const MapPage(), const CameraPage(), const MapPage()][selectedPageIndex],
    );
  }
}