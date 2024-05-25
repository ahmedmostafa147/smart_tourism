import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/create_plan_controller.dart';

class LocalPlanScreen extends StatelessWidget {
  final PlanController planController = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                planController.plan.update((plan) {
                  plan?.planReview = value;
                });
              },
              decoration: InputDecoration(labelText: 'Plan Review'),
            ),
            TextField(
              onChanged: (value) {
                planController.plan.update((plan) {
                  plan?.planBudget = int.parse(value);
                });
              },
              decoration: InputDecoration(labelText: 'Plan Budget'),
            ),
            TextField(
              onChanged: (value) {
                planController.plan.update((plan) {
                  plan?.planDuration = int.parse(value);
                });
              },
              decoration: InputDecoration(labelText: 'Plan Duration'),
            ),
            TextField(
              onChanged: (value) {
                planController.plan.update((plan) {
                  plan?.destination = value;
                });
              },
              decoration: InputDecoration(labelText: 'Destination'),
            ),
            ElevatedButton(
              onPressed: () {
                planController.createPlan(planController.plan.value);
              },
              child: Text('Create Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
