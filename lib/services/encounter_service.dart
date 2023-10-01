import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:noktonokto/models/encounter.dart';
import 'package:http/http.dart' as http;
import 'package:noktonokto/services/user_service.dart';
import 'package:noktonokto/utils/constants.dart';

List<Encounter> getMockEncounters() {
  return [
    Encounter(1,  "Cat", "Mały dziki kot", 52, 21, false, false, ["https://upload.wikimedia.org/wikipedia/commons/3/33/Stray_cat_on_wall.jpg"], DateTime.now()),
    Encounter(2,  "Cat", "Leżał koło sklepu", 52.2, 20.8, false, false, ["https://www.firstforwomen.com/wp-content/uploads/sites/2/2019/10/photos-of-chonky-cats.jpg?w=1024"], DateTime.now()),
    Encounter(3,  "Cat", "Miał założoną obroże", 52.1, 20.9, false, false, ["https://images.all-free-download.com/images/graphiclarge/cat_picture_elegant_garden_scene_6933450.jpg"], DateTime.now())
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

  static const String ENCOUNTER_URL = "$BACKEND_BASE_URL/encounters";

  Encounter? getSightingById(int id) {
    return Encounter(id,  'Cat', 'small wild cat', 51.99074828576804, 21.234140746236903, false, false, ['https://viosna.pl/wp-content/uploads/10102009855-255x300.png', 'https://s3.eu-central-1.amazonaws.com/cdn.koty.pl/baby_cat_png_12_1_0e0fc56629.png'], DateTime.now());
  }

  Future<List<Encounter>> getAllEncounters() async {
        final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Token": userService.token ?? '',
    };

    final response =
        await http.get(Uri.parse("$ENCOUNTER_URL/get"), headers: headers);

            if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: ${response.reasonPhrase ?? ""}');
    }

    List<Encounter> encounters = List.empty(growable: true);
    for(Map<String, dynamic> encounter in jsonDecode(response.body)) {
      encounters.add(Encounter.fromJson(encounter));
    }
    print('encounters');
    print(encounters);
    return encounters.toList();
  }

  // List<Encounter> getEncountersInCircle(
  //     double latitude, double longitude, double radius) {}

  Future<void> createEncounter(String animal, String description, double latitude,
      double longitude, bool isDangerous, bool isAbused, XFile image) async {
    final request = http.MultipartRequest("POST", Uri.parse("$HOSTING_BASE_URL/upload"));
      request.files.add(http.MultipartFile.fromBytes("file", File(image.path).readAsBytesSync(),
          filename: image.name));

    final hostingResponse  = await http.Response.fromStream(await request.send());

        if (hostingResponse.statusCode < 200 || hostingResponse.statusCode >= 300) {
      throw Exception('${hostingResponse.statusCode}: ${hostingResponse.reasonPhrase ?? ""}');
    }

    var imageUrl = jsonDecode(hostingResponse.body)["file_url"];
    print(imageUrl);
        final body = {
      'title': animal,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'is_dangerous': isDangerous,
      'is_abused': isAbused,
      'image_urls': jsonEncode([imageUrl]),
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

  Future<String> getAIResult(String filepath) async {
    String API_TOKEN = "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";
    String API_URL = "https://api-inference.huggingface.co/models/AliGhiasvand86/10-animals-classification";
    final headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $API_TOKEN",
    };

    final response =
            await http.post(Uri.parse(API_URL), body: File(filepath).readAsBytesSync(), headers: headers);
    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: ${response.reasonPhrase ?? ""}');
    }

    for(Map<String, dynamic> result in jsonDecode(response.body)) {
      return result['label'];
    }
    return 'Did not get an answer from AI';
  }
}
