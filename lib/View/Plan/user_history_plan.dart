import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/user_plan/user_history.dart';

class UserHistoryPlansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserHistoryPlans userHistoryPlansController =
        Get.put(UserHistoryPlans());

    return Scaffold(
      appBar: AppBar(
        title: Text('User History Plans'),
      ),
      body: Obx(() {
        if (userHistoryPlansController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (userHistoryPlansController.userHistoryPlans.isEmpty) {
          return Center(child: Text('No plans found'));
        }

        return ListView.builder(
          itemCount: userHistoryPlansController.userHistoryPlans.length,
          itemBuilder: (context, index) {
            final plan = userHistoryPlansController.userHistoryPlans[index];
            return Card(
              elevation: 2,
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Destination: ${plan.destination}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('Budget: \$${plan.planBudget}',
                        style: TextStyle(fontSize: 16)),
                    Text('Duration: ${plan.planDuration} days',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('Restaurants:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    for (var restaurant in plan.restaurantNames)
                      Text('- $restaurant', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text('Hotels:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    for (var hotel in plan.hotelNames)
                      Text('- $hotel', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text('Places:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    for (var place in plan.placeNames)
                      Text('- $place', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
