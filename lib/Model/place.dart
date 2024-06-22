class Place {
  final String placeName;
  final int price;
  final String governorate;
  final String placeLoc;
  final String placeImage;
  final double rate;

  Place({
    required this.placeName,
    required this.price,
    required this.governorate,
    required this.placeLoc,
    required this.placeImage,
    required this.rate,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeName: json['place_name'] ?? '',
      price: json['price'] ?? 0,
      governorate: json['governorate'] ?? '',
      placeLoc: json['place_loc'] ?? '',
      placeImage: json['place_image'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
    );
  }
}
