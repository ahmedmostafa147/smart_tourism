import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/search_controller/recent_search_controller.dart';

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
          return ListView.builder(
            itemCount: controller.recentSearches.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.recentSearches[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    controller.removeRecentSearch(index);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
