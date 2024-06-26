import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/may_like.dart';

class RecommendationsScreen extends StatelessWidget {
  final MayLikedController controller = Get.put(MayLikedController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.mayLikedItems.isEmpty) {
        return Center(child: Text('No recommendations found'));
      } else {
        return ListView.builder(
          itemCount: controller.mayLikedItems.length,
          itemBuilder: (context, index) {
            final recommendation = controller.mayLikedItems[index];
            return Card(
              child: ListTile(
                leading: recommendation.imgLink.startsWith('data:image')
                    ? Image.memory(
                        base64Decode(recommendation.imgLink.split(',')[1]))
                    : Image.network(recommendation.imgLink),
                title: Text(recommendation.title),
                subtitle: Text(
                    '${recommendation.country} - \$${recommendation.price.toString()}'),
                trailing: Text(recommendation.tags),
              ),
            );
          },
        );
      }
    });
  }
}
