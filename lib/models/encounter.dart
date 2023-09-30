class Encounter {
  final int id;
  final int authorId;
  final String animal;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;
  final DateTime createdAt;

  Encounter(this.id, this.authorId, this.animal, this.description, this.latitude,
      this.longitude, this.imageUrls, this.createdAt);

      
  factory Encounter.fromJson(Map<String, dynamic> json) {
    return Encounter(
      json['id'] as int,
      json['authorId'] as int,
      json['animal'] as String,
      json['description'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['imageUrls'] as List<String>,
      json["createdAt"] as DateTime,
    );
  }
}
