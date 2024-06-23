import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/search_controller/search_controller.dart';

class RecentSearchPage extends StatelessWidget {
  final SearchControllerOne searchController = Get.put(SearchControllerOne());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Searches'),
      ),
      body: Obx(() {
        if (searchController.recentSearches.isEmpty) {
          return Center(child: Text('No recent searches found'));
        } else {
          return ListView.builder(
            itemCount: searchController.recentSearches.length,
            itemBuilder: (context, index) {
              final recentSearch = searchController.recentSearches[index];
              return ListTile(
                title: Text(recentSearch.name),
                onTap: () {
                  searchController.searchController.text = recentSearch.name;
                  var params = SearchParameters(name: recentSearch.name);
                  searchController.search(params);
                  Navigator.pop(context); // Close the recent searches page
                },
              );
            },
          );
        }
      }),
    );
  }
}
