class PlaceModel {
  final String id;
  final String place;
  final String district;
  final double lattitude;
  final double longitude;
  final String details;
  final String mainImage;
  final List<String> subImage;

  PlaceModel({
    required this.id,
    required this.place,
    required this.district,
    required this.lattitude,
    required this.longitude,
    required this.details,
     required this.mainImage,
    required this.subImage,
  });
}
