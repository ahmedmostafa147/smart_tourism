import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/plan_controller/model_plan/model_ai_controller.dart';

class RecommendationScreen extends StatelessWidget {
  final String planName;
  final ModelAIController controller = Get.put(ModelAIController());

  RecommendationScreen({required this.planName});

  @override
  Widget build(BuildContext context) {
    final List<Color> dayColors = [
      Color(0xFF1976D2), // أزرق داكن
      Color(0xFF4CAF50), // أخضر فاتح
      Color(0xFFD32F2F), // أحمر داكن
      Color(0xFF9C27B0),

      Color(0xFF424242), // رمادي داكن

      Color(0xFF4C566A),
      Color(0xFFD08770),
      Color(0xFFA3BE8C),
      Color(0xFFB48EAD),
      Color(0xFF88C0D0),
      Color(0xFFBF616A),
      Color(0xFFEBCB8B),
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
                          'Plan #${recommendation.planNumber} - ${_cleanText(recommendation.hotel)}'),
                      subtitle: Text(
                        'Total Plan Price: \$${recommendation.totalPlanPrice.toStringAsFixed(2)}\n'
                        'Additional Amount Needed: ${_cleanText(recommendation.additionalAmountNeeded)}',
                      ),
                      children: recommendation.planRecommendations
                          .map((recommendation) {
                        return ListTile(
                          title: Text(
                            _cleanText(recommendation),
                          ),
                        );
                      }).toList(),
                      leading: IconButton(
                        onPressed: () async {
                          // Call saveRecommendation method here
                          await controller.saveRecommendation(recommendation);
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

  // دالة لتنظيف النصوص من الأحرف الغريبة
  String _cleanText(String input) {
    return input.replaceAll(
        RegExp(r'[^\x00-\x7F]'), ''); // Remove non-ASCII characters
  }
}
