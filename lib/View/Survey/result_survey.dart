import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class ResultSurvey extends StatelessWidget {
  ResultSurvey({super.key});
  final SurveySaveController surveyController = Get.put(SurveySaveController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Survey Results'.tr),
        ),
        body: Column(children: [
          CustomMaterialButton(
            buttonText: "Fetch Survey Results".tr,
            onPressed: () async {
              await surveyController.fetchSurveyResults();
            },
          ),
        ]));
  }
}
