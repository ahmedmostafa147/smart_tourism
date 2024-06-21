import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/model_plan/history_plan_controller.dart';

class SavedPlansScreen extends StatelessWidget {
  final SavedPlansController controller = Get.put(SavedPlansController());

  SavedPlansScreen() {
    controller.fetchSavedPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Plans'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: controller.savedPlans.length,
                itemBuilder: (context, index) {
                  final recommendation = controller.savedPlans[index];
                  return Card(
                    color: Colors.blueAccent[900],
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
                    ),
                  );
                },
              ),
      ),
    );
  }
}
