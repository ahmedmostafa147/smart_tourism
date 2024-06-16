import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/history_plan_controller.dart';

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
                  final plan = controller.savedPlans[index];
                  return Card(
                    child: ListTile(
                      title: Text(plan.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${plan.price}'),
                          Text('Tags: ${plan.tags}'),
                          Text('Governorate: ${plan.governorate}'),
                          Text('Day: ${plan.day}'),
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
