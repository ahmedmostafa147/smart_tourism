import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/plan_controller/model_plan/model_ai_controller.dart';

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

                  Color cardColor;
                  if (recommendation.planNumber >= 1 &&
                      recommendation.planNumber <= 5) {
                    cardColor = dayColors[recommendation.planNumber - 1];
                  } else {
                    cardColor = Colors.white;
                  }

                  return Card(
                    color: cardColor,
                    child: ExpansionTile(
                      title: Text(
                          'Plan #${recommendation.planNumber} - ${recommendation.hotel}'),
                      subtitle: Text(
                        'Total Plan Price: \$${recommendation.totalPlanPrice.toStringAsFixed(2)}\n'
                        'Additional Amount Needed: ${recommendation.additionalAmountNeeded}',
                      ),
                      children: recommendation.planRecommendations
                          .map((recommendation) {
                        // Parse day and details from the recommendation string
                        final parts = recommendation.split(':');
                        final day = parts[0];
                        final details = parts.length > 1 ? parts[1] : '';

                        return ListTile(
                          title: Text(day),
                          subtitle: Text(details.trim()),
                        );
                      }).toList(),
                      leading: IconButton(
                        onPressed: () async {
                          await controller.saveRecommendation(recommendation,
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Recommendation saved successfully!'),
                            ),
                          );
                        },
                        icon: Icon(Icons.bookmark_add_outlined),
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
