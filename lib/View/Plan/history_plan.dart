import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/model_plan/history_plan_controller.dart';

class SavedPlansScreen extends StatelessWidget {
  final SavedPlansController controller = Get.put(SavedPlansController());

  SavedPlansScreen() {
    controller.fetchSavedPlans();
  }

  final List<Color> dayColors = [
    Colors.blueGrey[900]!,
    Colors.red[900]!,
    Colors.green[900]!,
    Colors.blue[900]!,
    Colors.orange[900]!,
    Colors.purple[900]!,
    Colors.brown[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Plans'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.savedPlans.length,
                itemBuilder: (context, index) {
                  final plan = controller.savedPlans[index];

                  Color cardColor;
                  if (plan.planNumber >= 1 && plan.planNumber <= 7) {
                    cardColor = dayColors[plan.planNumber - 1];
                  } else {
                    cardColor = Colors.white;
                  }

                  return Card(
                    child: ExpansionTile(
                      title: Text('Plan #${plan.planNumber} - ${plan.hotel}'),
                      subtitle: Text(
                        'Total Plan Price: \$${plan.totalPlanPrice}\n'
                        'Additional Amount Needed: ${plan.additionalAmountNeeded}',
                      ),
                      children: plan.planRecommendations
                          .map((recommendation) => ListTile(
                                title: Text('Day ${recommendation.dayNumber}'),
                                subtitle: Text(
                                  '${recommendation.recommendationType}\n'
                                  '${recommendation.recommendationDescription}\n'
                                  'Price: \$${recommendation.recommendationPrice}',
                                ),
                              ))
                          .toList(),
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
