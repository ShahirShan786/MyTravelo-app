class PlaceModel {
  final String id;
  final String place;
  final String district;
  final String location;
  final String details;
  final String mainImage;
  final List<String> subImage;

  PlaceModel({
    required this.id,
    required this.place,
    required this.district,
    required this.location,
    required this.details,
     required this.mainImage,
    required this.subImage,
  });
}
