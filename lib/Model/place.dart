class Place {
  final String placeName;
  final int price;
  final String governorate;
  final String placeLoc;
  final String placeImage;
  final String comment;
  final double rate;
  final int place_id;

  Place({
    required this.placeName,
    required this.price,
    required this.governorate,
    required this.placeLoc,
    required this.placeImage,
    required this.rate,
    required this.comment,
    required this.place_id,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeName: json['place_name'] ?? '',
      price: json['price'] ?? 0,
      governorate: json['governorate'] ?? '',
      placeLoc: json['place_loc'] ?? '',
      placeImage: json['place_image'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      place_id: json['place_id'] ?? 0,
    );
  }
}
