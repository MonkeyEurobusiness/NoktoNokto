import 'dart:convert';


class Encounter {
  final int id;
  final String animal;
  final String description;
  final double latitude;
  final double longitude;
  final bool isDangerous;
  final bool isAbused;
  final List<String> imageUrls;
  final DateTime createdAt;

  Encounter(this.id, this.animal, this.description, this.latitude,
      this.longitude, this.isDangerous, this.isAbused, this.imageUrls,  this.createdAt);

      
  factory Encounter.fromJson(Map<String, dynamic> json) {
    return Encounter(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['is_dangerous'] as bool,
      json['is_abused'] as bool,
      jsonDecode(json['image_urls']).cast<String>() as List<String>,
      DateTime.parse(json["created_at"]),
    );
  }
}
