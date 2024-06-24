import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/user_plan/user_history.dart';

class UserHistoryPlansScreen extends StatelessWidget {
  final UserHistoryPlans controller = Get.put(UserHistoryPlans());

  UserHistoryPlansScreen() {
    // Fetch user history plans when the screen is initialized
    controller.fetchUserHistoryPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Plans'),
      ),
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? CircularProgressIndicator()
              : controller.userHistoryPlans.isEmpty
                  ? Text('No history plans found.')
                  : ListView.builder(
                      itemCount: controller.userHistoryPlans.length,
                      itemBuilder: (context, index) {
                        final plan = controller.userHistoryPlans[index];
                        return ListTile(
                          title: Text(plan['hotel'] ?? 'No Hotel Name'),
                          subtitle: Text('Plan Number: ${plan['plan_number']}'),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
