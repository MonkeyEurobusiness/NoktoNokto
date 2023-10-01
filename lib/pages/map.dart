import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noktonokto/data/pin.dart';
import 'package:noktonokto/services/encounter_service.dart';

import '../models/encounter.dart';

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

  late Map<MarkerId, Marker> _markers = {};
  late Map<String, Encounter> _encounters = {};

  late List<Marker> _serverMarkers = [];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/Main.png', 100);
    List<Encounter> encounters;
    // Pobierz dane o spotkaniu na podstawie ID.
    try {
      encounters = await EncounterService.getInstance().getAllEncounters();
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
        content: Text('Something went wrong. Couldn\'t load pins!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    for (Encounter encounter in encounters) {
      final markerId = MarkerId(encounter.id.toString());
      final marker = Marker(
        markerId: markerId,
        position: LatLng(encounter.latitude, encounter.longitude),
        icon: await _getMarkerImage(encounter.animal),
        /*infoWindow: InfoWindow(
          title: encounter.animal,
          snippet: encounter.description,
        ),*/
        onTap: () => _onMarkerTapped(encounter), // Add onTap here
      );

      _markers[markerId] = marker;
      _encounters[markerId.value] = encounter;
    }

    setState(() {});
  }

  void _onMarkerTapped(Encounter encounter) {
    showModalBottomSheet(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          color: Theme.of(context).colorScheme.tertiary,
          child: ListView(
            children: [
              Padding(padding: EdgeInsets.all(12)),
              Center(
                  child: Text(encounter.animal, style: Theme.of(context).textTheme.headlineLarge)),
              Padding(padding: EdgeInsets.all(12)),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: encounter.imageUrls.length,
                itemBuilder: (context, index) {
                  return Center(child: Image.network(encounter.imageUrls[index]));
                },
              ),
              Padding(padding: EdgeInsets.all(12)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(12)),
                  RichText(
                      text: TextSpan(style: Theme.of(context).textTheme.titleMedium, children: [
                    const TextSpan(
                        text: "Description: ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: encounter.description)
                  ])),
                  Padding(padding: EdgeInsets.all(12)),
                ],
              ),
              Padding(padding: EdgeInsets.all(12))
            ],
          ),
        );
      },
    );
  }

  Future<BitmapDescriptor> _getMarkerImage(String name) async {
    return BitmapDescriptor.fromBytes(
        await getBytesFromAsset(pinAssets[name] ?? pinAssets["Other"]!, 100));
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
        markers: Set<Marker>.of(_markers.values),
        onTap: (LatLng? position) {
          // Jeśli jest naciśnięty marker
          if (position != null) {
            final markerId = _getMarkerId(position);
            final encounter = _encounters[markerId.value];
            if (encounter != null) {
              _onMarkerTapped(encounter);
            }
          }
        });
  }

  MarkerId _getMarkerId(LatLng position) {
    // Return the MarkerId of the marker at the given position.
    // In this example, we are assuming each marker has a unique position.
    return _markers.entries.firstWhere((entry) => entry.value.position == position).key;
  }
}
