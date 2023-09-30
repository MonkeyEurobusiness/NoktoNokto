import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;
import 'package:flutter_map/plugin_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Geoportal Map Example')),
        body: FlutterMap(
          options: MapOptions(
            center: LatLng(52.2297, 21.0122), // Centrum na Warszawę
            zoom: 6,
            crs: Epsg3857(),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://mapy.geoportal.gov.pl/wss/service/PZGIK/BDOO/WMTS/aktualne?&SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=BDOO&STYLE=default&TILEMATRIXSET=EPSG:2180&TILEMATRIX=EPSG:2180:{z}&TILEROW={y}&TILECOL={x}&FORMAT=image/png',
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('Tytul'),
      ),
      body: Center(

      ),
    );
  }
}

class Epsg2180 extends proj4.Crs {
  static final proj4.Projection _proj = proj4.Projection.add(
    'EPSG:2180',
    '+proj=tmerc +lat_0=0 +lon_0=19 +k=0.9993 +x_0=500000 +y_0=-5300000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs +type=crs',
  );

  const Epsg2180() : super.fromProjection(_proj);
}