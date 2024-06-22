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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hotel_name'] = this.hotelName;
    data['price'] = this.price;
    data['governorate'] = this.governorate;
    data['hotel_loc'] = this.hotelLoc;
    data['hotel_image'] = this.hotelImage;
    data['rate'] = this.rate;
    data['comment'] = this.comment;
    data['place_id'] = this.place_id;
    return data;
  }
}
