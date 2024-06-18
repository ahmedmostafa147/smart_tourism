import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/favorite/favorite_controller.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    favoriteController.fetchFavorites();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Obx(() {
        if (favoriteController.favorites.isEmpty) {
          return Center(child: Text('No favorites found.'));
        } else {
          return ListView.builder(
            itemCount: favoriteController.favorites.length,
            itemBuilder: (context, index) {
              final favorite = favoriteController.favorites[index];
              return ListTile(
                title: Text(favorite.name),
                subtitle: Text(favorite.location),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    favoriteController.deleteFavorite(favorite.id);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }

  void _showAddFavoriteDialog(BuildContext context) {
    final typeController = TextEditingController();
    final nameController = TextEditingController();
    final locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Favorite'),
          actions: [
            TextButton(
              onPressed: () {
                final type = typeController.text;
                final name = nameController.text;
                final location = locationController.text;

                if (type.isNotEmpty && name.isNotEmpty && location.isNotEmpty) {
                  favoriteController.createFavorite(type, name, location);
                  Get.back();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
