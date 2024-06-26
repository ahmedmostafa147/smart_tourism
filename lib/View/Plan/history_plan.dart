import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/model_plan/history_plan_controller.dart';

class SavedPlansScreen extends StatelessWidget {
  final SavedPlansController controller = Get.put(SavedPlansController());

  SavedPlansScreen() {
    controller.fetchSavedPlans();
  }

  final List<Color> dayColors = [
    Color(0xFF1976D2), // أزرق داكن
    Color(0xFF4CAF50), // أخضر فاتح
    Color(0xFFD32F2F),
    Color(0xFF9C27B0),
    Color(0xFF424242),
    Color(0xFF4C566A),
    Color(0xFFD08770),
    Color(0xFFA3BE8C),
    Color(0xFFB48EAD),
    Color(0xFF88C0D0),
    Color(0xFFBF616A),
    Color(0xFFEBCB8B),
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
                    color: cardColor,
                    child: ExpansionTile(
                      title: Text('Plan #${plan.planNumber} - ${plan.hotel}'),
                      subtitle: Text(
                        'Total Plan Price: \$${plan.totalPlanPrice}\n'
                        'Additional Amount Needed: ${plan.additionalAmountNeeded}',
                      ),
                      children: plan.planRecommendations
                          .map((recommendation) => ListTile(
                                title: Text('${recommendation}'),
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
