import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/search_controller/search_controller.dart';

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
        if (searchController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (searchController.searchResults.isEmpty) {
          return Center(child: Text('No results found'));
        } else {
          return ListView.builder(
            itemCount: searchController.searchResults.length,
            itemBuilder: (context, index) {
              final result = searchController.searchResults[index];
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      result.image,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 200);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16.0, color: Colors.grey),
                              SizedBox(width: 4.0),
                              Text('${result.governorate}, ${result.country}'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Price: ${result.price} \$',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Rating: ${result.rate.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
