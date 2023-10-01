import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noktonokto/data/categories.dart';

import 'menu.dart';

class DisplayPictureScreen extends StatefulWidget {

  final String imagePath;
  final double aspectRatio;

  const DisplayPictureScreen({super.key, required this.imagePath, required this.aspectRatio});

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen>  {
  String dropdownValue = categories.first;
  bool isDangerous = false;
  bool isAbuse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(title: Text("Captured photo"), ),
      body: ListView(
          children: [
            Spacer(),
            Container(
              height: 300,
              child: AspectRatio(
                  aspectRatio: widget.aspectRatio,
                  child: Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.fill, // lub BoxFit.fitHeight
                  )
              ),
            ),
            Padding(padding: EdgeInsets.all(12)),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(12)),
                Text("Species", style: Theme.of(context).textTheme.labelLarge),
                Padding(padding: EdgeInsets.all(24)),
                DropdownMenu<String>(
                  initialSelection: categories.first,
                  onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                  },
                  dropdownMenuEntries: categories.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                ),
                Spacer()
              ],
            ),
            Padding(padding: EdgeInsets.all(12)),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(12)),
                Text("Potentially dangerous", style: Theme.of(context).textTheme.labelLarge),
                Checkbox(value: isDangerous, onChanged: (bool? value){
                  setState(() {
                    isDangerous = value!;
                  });
                }),
                Padding(padding: EdgeInsets.all(6)),
                Text("Report animal abuse", style: Theme.of(context).textTheme.labelLarge),
                Checkbox(value: isAbuse, onChanged: (bool? value){
                  setState(() {
                    isAbuse = value!;
                  });
                }),
                Spacer()
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(12)),
                Text("Description", style: Theme.of(context).textTheme.labelLarge),
                Padding(padding: EdgeInsets.all(12)),
                Container(
                  width: 240, child: const TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 5,
                )),
                Spacer()
              ],
            ),
            Padding(padding: EdgeInsets.all(24)),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Spacer(),
                  Padding(padding: EdgeInsets.all(24)),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: FilledButton(
                      style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.secondary),
                      onPressed: () async {
                        print('login');
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const MenuPage()),);
                      },
                      child: Text("Send", style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(24)),
                  Spacer()
                ],
              ),
            ),
            Spacer()
          ],
        ),
    );
  }
}