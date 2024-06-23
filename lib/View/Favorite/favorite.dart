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
        if (favoriteController.isLoading.value) {
          return Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (favoriteController.favorites.isEmpty) {
          return Center(child: Text('No favorites found.'));
        } else {
          return ListView.builder(
            itemCount: favoriteController.favorites.length,
            itemBuilder: (context, index) {
              final favorite = favoriteController.favorites[index];
              return ListTile(
                title: Text(favorite.name),
                subtitle: Text(favorite.location),
                trailing: Obx(() {
                  if (favoriteController.deletingIds.contains(favorite.favId)) {
                    return CircularProgressIndicator(); // Show loading indicator while deleting
                  } else {
                    return IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        favoriteController.deleteFavorite(favorite.favId);
                      },
                    );
                  }
                }),
              );
            },
          );
        }
      }),
    );
  }
}
