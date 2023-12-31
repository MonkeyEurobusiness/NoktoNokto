import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:noktonokto/services/encounter_service.dart';

import 'create_encounter.dart';

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
            backgroundColor: Theme.of(context).colorScheme.primary,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.camera),
              onPressed: () async {
              bool wasFlashOn = _controller.value.flashMode == FlashMode.torch;

              if (!wasFlashOn) {
                await _controller.setFlashMode(FlashMode.off);
              }
              XFile file = await _controller.takePicture();
              await _controller.setFlashMode(FlashMode.off);
              setState(() {
                _flashState = false;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    imagePath: file.path,
                    aspectRatio: _controller.value.aspectRatio,
                  ),
                ),
              );

            },

            ),
            body: Stack(
                children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  child: Container(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                    child: Row(
                      children: [
                        Icon(Icons.flash_on, color: Theme.of(context).colorScheme.secondary, size: 40,),
                        Switch(
                          inactiveTrackColor: Theme.of(context).colorScheme.tertiary,
                          value: _flashState,
                          onChanged: (value) {
                            setState(() {
                              _flashState = value;
                              _controller.setFlashMode(_flashState ? FlashMode.torch : FlashMode.off);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
              )
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
