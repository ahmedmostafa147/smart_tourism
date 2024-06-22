class Place {
  final int placeId;
  final String placeName;
  final String placeLoc;
  final String placeImage;
  final String comment;
  final double rate;
  final double price;

  Place({
    required this.placeId,
    required this.placeName,
    required this.placeLoc,
    required this.placeImage,
    required this.comment,
    required this.rate,
    required this.price,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      placeName: json['place_name'],
      placeLoc: json['place_loc'],
      placeImage: json['place_image'],
      comment: json['comment'],
      rate: json['rate'].toDouble(),
      price: json['price'].toDouble(),
    );
  }
}
