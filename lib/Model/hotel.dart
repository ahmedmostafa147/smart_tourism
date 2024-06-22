class Hotel {
  final String hotelName;
  final int price;
  final String governorate;
  final String hotelLoc;
  final String hotelImage;
  final double rate;
  final String comment;
  final int place_id;

  Hotel({
    required this.comment,
    required this.place_id,
    required this.hotelName,
    required this.price,
    required this.governorate,
    required this.hotelLoc,
    required this.hotelImage,
    required this.rate,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      hotelName: json['hotel_name'] ?? '',
      price: json['price'] ?? 0,
      governorate: json['governorate'] ?? '',
      hotelLoc: json['hotel_loc'] ?? '',
      hotelImage: json['hotel_image'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      place_id: json['place_id'] ?? 0,
    );
  }
}
