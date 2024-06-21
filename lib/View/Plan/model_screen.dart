import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/model_plan/model_ai_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import 'package:smart_tourism/View/Plan/display_plan.dart';
import 'package:smart_tourism/View/Plan/widget/autocomplete.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class PreferencesScreen extends StatelessWidget {
  final ModelAIController controller = Get.put(ModelAIController());
  final TextEditingController planNameController = TextEditingController();

  PreferencesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Preferences'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 16.h),
              CustomTextForm(
                hintText: "Plan Name",
                controller: planNameController,
                labelText: "Plan Name",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25.h),
              AutocompleteField(
                label: "Country",
                options: controller.countries,
                controller: controller.countryController,
                hintText: 'Enter country name',
                isValidSelection: controller.isValidCountry,
                onSelected: (String selection) {
                  controller.showGovernoratesForSelectedCountry(selection);
                },
              ),
              SizedBox(height: 25.h),
              Obx(
                () => AutocompleteField(
                  label: "Choose Governorate",
                  options: controller.filteredGovernorates.toList(),
                  controller: controller.governorateController,
                  isValidSelection: controller.isValidGovernorate,
                  hintText: 'Enter governorate name',
                ),
              ),
              SizedBox(height: 25.h),
              AutocompleteField(
                label: "Number of Days",
                options: controller.numDays,
                controller: controller.numDaysController,
                isValidSelection: controller.isValidnumDays,
                hintText: 'Enter number of days',
              ),
              SizedBox(height: 25.h),
              AutocompleteField(
                label: "Budget",
                options: controller.budget,
                controller: controller.budgetController,
                isValidSelection: controller.isValidbudget,
                hintText: 'Enter budget',
              ),
              SizedBox(height: 25.h),
              AutocompleteField(
                label: "Number of Plans",
                options: controller.numPlans,
                controller: controller.num_plansController,
                isValidSelection: controller.isValidnum_plans,
                hintText: 'Enter budget',
              ),
              SizedBox(height: 25.h),
              Obx(() => CustomMaterialButton(
                    buttonText: controller.isLoading.value
                        ? 'Loading...'
                        : 'Get Recommendations',
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        await controller.getRecommendations();
                        if (controller.recommendations.isNotEmpty) {
                          controller.isLoading.value = false;
                          Get.to(() => RecommendationScreen(
                              planName: planNameController.text));
                        } else {
                          Get.snackbar('Error', 'No recommendations found');
                        }
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
