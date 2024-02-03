import 'package:flutter/material.dart';
import 'package:smart_tourism/View/Home/widgets/list_view_discover_places.dart';

class ListFavoritePlaces extends StatelessWidget {
  const ListFavoritePlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: const ListDiscoverPlaces(),
      ),
    );
  }
}
