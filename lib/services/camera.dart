import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _flashState = false;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );
    await _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.camera),
                  onPressed: () async {
                    Location location = new Location();
                    bool _serviceEnabled;
                    PermissionStatus _permissionGranted;
                    LocationData _locationData;

                    _serviceEnabled = await location.serviceEnabled();
                    if (!_serviceEnabled) {
                      _serviceEnabled = await location.requestService();
                      if (!_serviceEnabled) {
                        return;
                      }
                    }

                    _permissionGranted = await location.hasPermission();
                    if (_permissionGranted == PermissionStatus.denied) {
                      _permissionGranted = await location.requestPermission();
                      if (_permissionGranted != PermissionStatus.granted) {
                        return;
                      }
                    }

                    _locationData = await location.getLocation();

                    // ... reszta twojego kodu

                    print(_locationData.latitude); // drukuje szerokość geograficzną
                    print(_locationData.longitude); // drukuje długość geograficzną
                  },
                ),

                Switch(
                  value: _flashState,
                  onChanged: (value) {
                    setState(() {
                      _flashState = value;
                      _controller.setFlashMode(_flashState ? FlashMode.torch : FlashMode.off);
                    });
                  },
                )
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final double aspectRatio;

  const DisplayPictureScreen({Key? key, required this.imagePath, required this.aspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wyświetl zdjęcie')),
      body: Container(
        child: Center(
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.contain, // lub BoxFit.fitHeight
            )
          ),
        ),
      ),
    );
  }
}
