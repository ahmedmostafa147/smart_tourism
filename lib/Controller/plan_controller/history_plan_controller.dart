import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Core/End%20Points/endpoints.dart';
import 'dart:convert';
import 'create_plan_controller.dart';

class HistoryPlanController extends GetxController {
  var historyPlans = <Plan>[].obs;
  var isLoadingHistoryPlans = false.obs;

  Future<void> fetchHistoryPlans() async {
    isLoadingHistoryPlans.value = true;
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.historyPlans;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        Get.snackbar("Error", "Failed to fetch history plans");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingHistoryPlans.value = false;
    }
  }
}
