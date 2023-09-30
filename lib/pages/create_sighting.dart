import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final double aspectRatio;

  const DisplayPictureScreen({Key? key, required this.imagePath, required this.aspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
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