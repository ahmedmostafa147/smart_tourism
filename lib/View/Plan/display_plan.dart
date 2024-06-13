import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/plan_controller/model_ai_controller.dart';

class RecommendationScreen extends StatelessWidget {
  final String planName;
  final ModelAIController controller = Get.put(ModelAIController());

  RecommendationScreen({required this.planName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations for $planName'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = controller.recommendations[index];
                  return Card(
                    child: ListTile(
                      title: Text(recommendation.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${recommendation.price}'),
                          Text('Tags: ${recommendation.tags}'),
                          Text('Governorate: ${recommendation.governorate}'),
                          Text('Day: ${recommendation.day}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
