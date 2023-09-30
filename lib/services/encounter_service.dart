import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:noktonokto/models/encounter.dart';
import 'package:http/http.dart' as http;

class EncounterService {
  static const String CREATE_ENCOUNTER_URL = 'https://3ece850b-8473-4499-9330-41eac61d53dd.mock.pstmn.io/encounter';

  // Encounter? getSightingById(int id) {}

  // List<Encounter> getEncountersByAuthor(int authorId) {}

  // List<Encounter> getEncountersInCircle(
  //     double latitude, double longitude, double radius) {}

  Future<Encounter?> createEncounter(String animal, String description,
      double latitude, double longitude, List<XFile> images) async {

    final request =
        http.MultipartRequest("POST", Uri.parse(CREATE_ENCOUNTER_URL));
    for (XFile file in images) {
      request.files.add(http.MultipartFile.fromBytes(
          "picture", File(file.path).readAsBytesSync(),
          filename: file.path));
    }
    request.fields.addEntries(
      <String, String>{
        "animal": animal, 
        "description": description, 
        "latitude": latitude.toString(), 
        "longitude": longitude.toString()
        }.entries);
    final res = await request.send();

    return null;
  }
}
