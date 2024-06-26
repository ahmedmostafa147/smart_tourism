class Restaurant {
  final String restaurantName;
  final int price;
  final String governorate;
  final String restaurantLoc;
  final String restaurantImage;
  final double rate;
  final int rest_id;
  final String comment;

  Restaurant({
    required this.restaurantName,
    required this.price,
    required this.governorate,
    required this.restaurantLoc,
    required this.restaurantImage,
    required this.rate,
    required this.rest_id,
    required this.comment,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantName: json['rest_name'] ?? '',
      price: json['price'] ?? 0,
      governorate: json['governorate'] ?? '',
      restaurantLoc: json['rest_loc'] ?? '',
      restaurantImage: json['rest_image'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
      rest_id: json['rest_id'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rest_name'] = this.restaurantName;
    data['price'] = this.price;
    data['governorate'] = this.governorate;
    data['rest_loc'] = this.restaurantLoc;
    data['rest_image'] = this.restaurantImage;
    data['rate'] = this.rate;
    data['rest_id'] = this.rest_id;
    data['comment'] = this.comment;
    return data;
  }
}
