import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageURL;
  final String price;
  final double rating;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageURL,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        width: 200, // Width of each card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  imageURL,
                  width: 200, // Width of image
                  height: 120, // Height of image
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 120);
                  },
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, color: const Color(0xffFF8527)),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: const Color(0xffFF8527)),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(
                        rating.toString(),
                        style: TextStyle(fontSize: 16, color: const Color(0xffFF8527)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    price,
                    style: TextStyle(fontSize: 16, color: const Color(0xffFF8527)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
