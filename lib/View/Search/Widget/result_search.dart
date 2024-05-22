import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/search_controller/search_controller.dart';

class ResultSearch extends StatelessWidget {
  final SearchControllerOne searchController = Get.put(SearchControllerOne());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: TextField(
          controller: searchController.searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
          ),
          style: TextStyle(color: Colors.white),
          onSubmitted: (query) {
            var params = SearchParameters(
                name: query); // Use the query to create search params
            searchController.search(params);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              searchController.searchController.clear();
              searchController.searchResults.clear();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (searchController.searchResults.isEmpty) {
          return ListView(
            children: [
              ListTile(
                title: Text('Recent Searches'),
                trailing: IconButton(
                  icon: Icon(Icons.clear_all),
                  onPressed: searchController.clearRecentSearches,
                ),
              ),
              for (String search in searchController.recentSearches)
                ListTile(
                  title: Text(search),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        searchController.removeRecentSearch(search),
                  ),
                  onTap: () {
                    var params = SearchParameters();
                    searchController.search(params);
                    searchController.searchController.text = params.name ?? '';
                  },
                ),
            ],
          );
        } else {
          return ListView.builder(
            itemCount: searchController.searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchController.searchResults[index].result),
              );
            },
          );
        }
      }),
    );
  }
}
