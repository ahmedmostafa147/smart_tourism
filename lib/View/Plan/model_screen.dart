import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/model_ai_controller.dart';
import 'package:smart_tourism/Model/model_get_recommendation.dart';

class RecommendationScreen extends StatelessWidget {
  final ModelAIController controller = Get.put(ModelAIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () => controller.getRecommendations(),
                    child: Text('Get Recommendations'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.recommendations.length,
                        itemBuilder: (context, index) {
                          final Recommendation recommendation =
                              controller.recommendations[index];
                          return ListTile(
                            title: Text(recommendation.title),
                            subtitle: Text(recommendation.tags),
                            trailing: Text(
                                '\$${recommendation.price.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
