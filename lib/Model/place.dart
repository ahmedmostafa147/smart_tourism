class Place {
  final int placeId;
  final String placeName;
  final String placeLoc;
  final String placeImage;
  final String governorate;
  final String comment;
  final double rate;
  final double price;

  Place({
    required this.placeId,
    required this.placeName,
    required this.placeLoc,
    required this.governorate,
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
      governorate: json['governorate'],
      placeImage: json['place_image'],
      comment: json['comment'],
      rate: json['rate'].toDouble(),
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['place_name'] = this.placeName;
    data['place_loc'] = this.placeLoc;
    data['governorate'] = this.governorate;
    data['place_image'] = this.placeImage;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    data['price'] = this.price;
    return data;
  }
}
