import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;

  MapWidget({required this.initialPosition});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Marker? _userSelectedMarker;

  List<Marker> _serverMarkers = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(52.2296756, 21.0122287), // przykład współrzędnych
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(51.109, 17.032), // przykład współrzędnych
    ),
  ];

  void _onMapLongPress(LatLng position) {
    final marker = Marker(
      markerId: MarkerId('user'), // id dla markera użytkownika
      position: position,
    );

    setState(() {
      _userSelectedMarker = marker; // Ustawienie markera użytkownika.
    });
  }

  // Funkcja zwracająca pozycję wybraną przez użytkownika.
  LatLng? getSelectedPosition() {
    return _userSelectedMarker?.position;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.initialPosition,
        zoom: 14,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onLongPress: _onMapLongPress,
      markers: {..._serverMarkers, if (_userSelectedMarker != null) _userSelectedMarker!},
    );
  }
}
