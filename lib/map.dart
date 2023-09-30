import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

class MapWidget extends StatefulWidget {
  final LatLng initialPosition;

  MapWidget({required this.initialPosition});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Marker? _userSelectedMarker;

  late List<Marker> _serverMarkers = [];


  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/Main.png', 100);

    _serverMarkers = [
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(52.2296756, 21.0122287), // przykład współrzędnych
        icon: await _getMarkerImage('cat'),
        infoWindow: InfoWindow(
          title: "Pierwszy marker",
          snippet: "Opis pierwszego markera",
        ),
      ),
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(51.109, 17.032), // przykład współrzędnych
        icon: await _getMarkerImage(''),
        infoWindow: InfoWindow(
          title: "Drugi marker",
          snippet: "Opis drugiego markera",
        ),
      ),
    ];

    setState(() {});
  }

  Future<BitmapDescriptor> _getMarkerImage(String name) async {
    if (name =='cat'){
      return  BitmapDescriptor.fromBytes(await getBytesFromAsset('assets/Cat_pin.png', 100));
    }
    return BitmapDescriptor.fromBytes(await getBytesFromAsset('assets/Main.png', 100));
  }


  void _onMapLongPress(LatLng position) async {
    final marker = Marker(
      markerId: MarkerId('user'),
      position: position,
      icon: await _getMarkerImage(''),
      infoWindow: InfoWindow(
        title: "Wybrany marker",
        snippet: "Opis wybranego markera",
      ),
    );

    setState(() {
      _userSelectedMarker = marker;
    });
  }

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
