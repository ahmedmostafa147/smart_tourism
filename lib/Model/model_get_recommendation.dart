class Recommendation {
  final String title;
  final double price;
  final String tags;
  final String governorate;
  final int day;

  Recommendation({
    required this.title,
    required this.price,
    required this.tags,
    required this.governorate,
    required this.day,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['Title'],
      price: json['Price'],
      tags: json['Tags'],
      governorate: json['Governorate'],
      day: json['Day'],
    );
  }
}
