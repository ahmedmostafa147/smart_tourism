class Restaurant {
  final String restaurantName;
  final int price;
  final String governorate;
  final String restaurantLoc;
  final String restaurantImage;
  final double rate;

  Restaurant({
    required this.restaurantName,
    required this.price,
    required this.governorate,
    required this.restaurantLoc,
    required this.restaurantImage,
    required this.rate,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantName: json['restaurant_name'] ?? '',
      price: json['price'] ?? 0,
      governorate: json['governorate'] ?? '',
      restaurantLoc: json['restaurant_loc'] ?? '',
      restaurantImage: json['restaurant_image'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
    );
  }
}
