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
}
