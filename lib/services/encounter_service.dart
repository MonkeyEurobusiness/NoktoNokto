import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:noktonokto/models/encounter.dart';
import 'package:http/http.dart' as http;
import 'package:noktonokto/utils/constants.dart';

class EncounterService {
  static EncounterService? instance = null;
  static EncounterService getInstance() {
    instance ??= EncounterService._();
    return instance!;
  }

  EncounterService._() {}

  static const String ENCOUNTER_URL = "$BACKEND_BASE_URL/encounter";

  Encounter? getSightingById(int id) {
    return Encounter(id, 5, 'Cat', 'small wild cat', 51.99074828576804, 21.234140746236903, ['https://viosna.pl/wp-content/uploads/10102009855-255x300.png', 'https://s3.eu-central-1.amazonaws.com/cdn.koty.pl/baby_cat_png_12_1_0e0fc56629.png'], DateTime.now());
  }

  // List<Encounter> getEncountersByAuthor(int authorId) {}

  // List<Encounter> getEncountersInCircle(
  //     double latitude, double longitude, double radius) {}

  Future<Encounter?> createEncounter(String animal, String description, double latitude,
      double longitude, List<XFile> images) async {
    final request = http.MultipartRequest("POST", Uri.parse(ENCOUNTER_URL));
    for (XFile file in images) {
      request.files.add(http.MultipartFile.fromBytes("picture", File(file.path).readAsBytesSync(),
          filename: file.path));
    }
    request.fields.addEntries(<String, String>{
      "animal": animal,
      "description": description,
      "latitude": latitude.toString(),
      "longitude": longitude.toString()
    }.entries);
    final res = await request.send();

    return null;
  }
}
