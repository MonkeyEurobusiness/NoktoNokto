import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:noktonokto/models/encounter.dart';
import 'package:http/http.dart' as http;
import 'package:noktonokto/services/user_service.dart';
import 'package:noktonokto/utils/constants.dart';

List<Encounter> getMockEncounters() {
  return [
    Encounter(1, 5, "Cat", "Mały dziki kot", 52, 21, ["https://upload.wikimedia.org/wikipedia/commons/3/33/Stray_cat_on_wall.jpg"], DateTime.now()),
    Encounter(2, 5, "Cat", "Leżał koło sklepu", 52.2, 20.8, ["https://www.firstforwomen.com/wp-content/uploads/sites/2/2019/10/photos-of-chonky-cats.jpg?w=1024"], DateTime.now()),
    Encounter(3, 5, "Cat", "Miał założoną obroże", 52.1, 20.9, ["https://images.all-free-download.com/images/graphiclarge/cat_picture_elegant_garden_scene_6933450.jpg"], DateTime.now())
  ];
}

class EncounterService {
  static EncounterService? instance = null;
  static EncounterService getInstance() {
    instance ??= EncounterService._();
    return instance!;
  }

  EncounterService._() {}
  final UserService userService = UserService.getInstance();

  static const String ENCOUNTER_URL = "$BACKEND_BASE_URL/encounter";

  Encounter? getSightingById(int id) {
    return Encounter(id, 5, 'Cat', 'small wild cat', 51.99074828576804, 21.234140746236903, ['https://viosna.pl/wp-content/uploads/10102009855-255x300.png', 'https://s3.eu-central-1.amazonaws.com/cdn.koty.pl/baby_cat_png_12_1_0e0fc56629.png'], DateTime.now());
  }

  // List<Encounter> getEncountersByAuthor(int authorId) {}

  // List<Encounter> getEncountersInCircle(
  //     double latitude, double longitude, double radius) {}

  Future<void> createEncounter(String animal, String description, double latitude,
      double longitude, XFile image) async {
    final request = http.MultipartRequest("POST", Uri.parse(HOSTING_BASE_URL));
      request.files.add(http.MultipartFile.fromBytes("file", File(image.path).readAsBytesSync(),
          filename: image.path));

    final hostingResponse  = await http.Response.fromStream(await request.send());

        if (hostingResponse.statusCode < 200 || hostingResponse.statusCode >= 300) {
      throw Exception('${hostingResponse.statusCode}: ${hostingResponse.reasonPhrase ?? ""}');
    }

    var imageUrl = jsonDecode(hostingResponse.body)["file_url"];

        final body = {
      'title': animal,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'image_urls': [imageUrl],
    };
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Token": userService.token ?? '',
    };

    final response =
        await http.put(Uri.parse("$ENCOUNTER_URL/add"), body: jsonEncode(body), headers: headers);
    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: ${response.reasonPhrase ?? ""}');
    }

  }
}
