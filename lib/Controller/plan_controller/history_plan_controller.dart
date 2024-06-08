import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Core/End%20Points/endpoints.dart';
import 'dart:convert';
import 'create_plan_controller.dart';

class PlanController extends GetxController {
  var historyPlans = <Plan>[].obs;

  Future<void> fetchHistoryPlans() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.historyPlans;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      historyPlans.value = data.map((item) => Plan.fromJson(item)).toList();
    } else {
      Get.snackbar("Error", "Failed to fetch history plans");
    }
  }
}
