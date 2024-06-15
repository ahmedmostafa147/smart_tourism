import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/history_plan_controller.dart';

class HistoryPlansScreen extends StatelessWidget {
  final HistoryPlanController controller = Get.put(HistoryPlanController());

  @override
  void initState() {
    controller.fetchHistoryPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Plans'),
      ),
      body: Obx(() {
        if (controller.isLoadingHistoryPlans.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.historyPlans.isEmpty) {
          return Center(child: Text('No plans found'));
        } else {
          return ListView.builder(
            itemCount: controller.historyPlans.length,
            itemBuilder: (context, index) {
              final plan = controller.historyPlans[index];
              return ListTile(
                title: Text(plan.destination),
                subtitle: Text(
                    'Duration: ${plan.planDuration} days, Budget: ${plan.planBudget}'),
              );
            },
          );
        }
      }),
    );
  }
}
