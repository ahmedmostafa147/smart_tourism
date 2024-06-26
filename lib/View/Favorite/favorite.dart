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
            child: CircularProgressIndicator(),
          ); // Show loading indicator
        } else if (favoriteController.favorites.isEmpty) {
          return Center(
            child: Text(
              'No favorites found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: favoriteController.favorites.length,
            itemBuilder: (context, index) {
              final favorite = favoriteController.favorites[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 36,
                  ),
                  title: Text(
                    favorite.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(favorite.location),
                  trailing: Obx(() {
                    if (favoriteController.deletingIds
                        .contains(favorite.favId)) {
                      return CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      ); // Show loading indicator while deleting
                    } else {
                      return IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.redAccent,
                        onPressed: () {
                          favoriteController.deleteFavorite(favorite.favId);
                        },
                      );
                    }
                  }),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
