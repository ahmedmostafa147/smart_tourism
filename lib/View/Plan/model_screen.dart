import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/model_ai_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import 'package:smart_tourism/View/Plan/display_plan.dart';
import 'package:smart_tourism/View/Plan/widget/autocomplete.dart';

class PreferencesScreen extends StatelessWidget {
  final ModelAIController controller = Get.put(ModelAIController());
  final TextEditingController ControllerPlanName = TextEditingController();

  PreferencesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Preferences'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextForm(
                hintText: "Plan Name",
                controller: ControllerPlanName,
                labelText: "Plan Name",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },
              ),
              Text(
                'Select preferences for your plan: $ControllerPlanName',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              AutocompleteField(
                label: "Country",
                options: controller.countries,
                controller: controller.countryController,
                hintText: 'Enter country name',
              ),
              AutocompleteField(
                label: "Choose Governorate",
                options: controller.governorates,
                controller: controller.governorateController,
                hintText: 'Enter governorate name',
              ),
              AutocompleteField(
                label: "Number of Days",
                options: controller.numDays,
                controller: controller.numDaysController,
                hintText: 'Enter number of days',
              ),
              AutocompleteField(
                label: "Budget",
                options: controller.budget,
                controller: controller.budgetController,
                hintText: 'Enter budget',
              ),
              ElevatedButton(
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    await controller.getRecommendations();
                    Get.to(() => RecommendationScreen(
                        planName: ControllerPlanName.value.text));
                  }
                },
                child: Obx(
                  () => Text(controller.isLoading.value
                      ? 'Loading...'
                      : 'Get Recommendations'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
