import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Search/Widget/recent_search.dart';
import 'package:smart_tourism/View/Search/Widget/text_field_search.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(onTap: () {}, child: TextFieldSearch()),
              RecentSearchesWidget()
            ],
          ),
        ),
      ),
    );
  }
}
