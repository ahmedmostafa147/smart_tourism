import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/scearch_controller.dart';
import 'package:smart_tourism/View/Search/Widget/container_recent_search.dart';
import 'package:smart_tourism/View/Search/Widget/enable_location.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchControllerFunction searchController =
        Get.put(SearchControllerFunction());
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Country'),
                onChanged: (value) => searchController.country.value = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Governorate'),
                onChanged: (value) =>
                    searchController.governorate.value = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) => searchController.category.value = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => searchController.name.value = value,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  searchController.search(
                    country: searchController.country.value,
                    governorate: searchController.governorate.value,
                    category: searchController.category.value,
                    name: searchController.name.value,
                  );
                },
                child: Text('Search'),
              ),
              Divider(),
              SizedBox(height: 10.h),
              Text(
                'Your Recent Searches'.tr,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              ContainerRecentSearch(),
              Divider(),
              SizedBox(height: 20.h),
              ContainerEnableLocation()
            ],
          ),
        ),
      ),
    );
  }
}
