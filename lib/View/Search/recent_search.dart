import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/search_controller/recent_search_controller.dart';
import '../../Controller/search_controller/search_controller.dart';

class RecentSearchesWidget extends StatelessWidget {
  final RecentSearchesController controller =
      Get.put(RecentSearchesController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.recentSearches.isEmpty) {
          return Center(child: Text('No recent searches'));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: controller.recentSearches.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2.0,
                child: InkWell(
                  onTap: () {
                    var params = SearchParameters(
                        name: controller.recentSearches[index]);
                    // Assuming you have a method to perform search
                    // when a recent search item is tapped
                    controller.fetchRecentSearches();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.recentSearches[index],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          controller.removeRecentSearch(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
