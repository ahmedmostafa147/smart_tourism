import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/plan_controller/model_ai_controller.dart';

class RecommendationScreen extends StatelessWidget {
  final String planName;
  final ModelAIController controller = Get.put(ModelAIController());

  RecommendationScreen({required this.planName});

  @override
  Widget build(BuildContext context) {
    // Define dark colors for each day
    final List<Color> dayColors = [
      Colors.blueGrey[900]!, // Day 1
      Colors.red[900]!, // Day 2
      Colors.green[900]!, // Day 3
      Colors.blue[900]!, // Day 4
      Colors.orange[900]!, // Day 5
      Colors.purple[900]!, // Day 6
      Colors.brown[900]!, // Day 7
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations for $planName'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = controller.recommendations[index];
                  // Determine the color of the card based on the day
                  Color cardColor;
                  if (recommendation.day >= 1 && recommendation.day <= 7) {
                    cardColor = dayColors[recommendation.day - 1];
                  } else {
                    cardColor = Colors.white;
                  }

                  return Card(
                    color: cardColor,
                    child: ListTile(
                      title: Text(
                        recommendation.title,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${recommendation.price}',
                              style: TextStyle(color: Colors.white)),
                          Text('Tags: ${recommendation.tags}',
                              style: TextStyle(color: Colors.white)),
                          Text('Governorate: ${recommendation.governorate}',
                              style: TextStyle(color: Colors.white)),
                          Text('Day: ${recommendation.day}',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.blueGrey[700],
                  thickness: 2.0,
                ),
              ),
      ),
    );
  }
}
