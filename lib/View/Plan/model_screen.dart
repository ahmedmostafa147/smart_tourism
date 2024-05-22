import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/model_ai_controller.dart';
import 'package:smart_tourism/Model/model_get_recommendation.dart';

class RecommendationScreen extends StatelessWidget {
  final ModelAIController controller = Get.put(ModelAIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'AI Will Make Recommendations for your next trip !',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text("Choose Country: "),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              items: <String>['Egypt', 'USA', 'France', 'Italy']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            Text("Choose Governorate: "),
            DropdownButton(
              items: <String>['Alexandria', 'Cairo', 'Giza', 'Luxor']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16.0),
            Text("num_days : "),
            SizedBox(height: 16.0),
            DropdownButton(
              items: <int>[1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            Text("budget : "),
            SizedBox(height: 16.0),
            DropdownButton(
              items: <int>[1000, 2000, 3000, 4000, 5000].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.getRecommendations();
                }
              },
              child: Text('Get Recommendations'),
            ),
            SizedBox(height: 20),
            Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Flexible(
                      child: ListView.builder(
                        itemCount: controller.recommendations.length,
                        itemBuilder: (context, index) {
                          final Recommendation recommendation =
                              controller.recommendations[index];
                          return ListTile(
                            title: Text(recommendation.title),
                            subtitle: Text(recommendation.tags),
                            trailing: Text(
                                '\$${recommendation.price.toStringAsFixed(2)}'),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
