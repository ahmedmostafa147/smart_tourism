import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/user_plan/create_plan_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import 'package:smart_tourism/View/Plan/widget/autocomplete.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class LocalPlanScreen extends StatelessWidget {
  final PlanController controller = Get.put(PlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Plan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 16),
              CustomTextForm(
                hintText: "Plan Name",
                controller: controller.planNameController,
                labelText: "Plan Name",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              CustomTextForm(
                hintText: "Country Name",
                controller: controller.countryController,
                labelText: "Country ",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Country  name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              CustomTextForm(
                hintText: "Budget Amount",
                controller: controller.budgetController,
                labelText: "Budget Amount",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              CustomTextForm(
                hintText: "Num Days",
                controller: controller.numDaysController,
                labelText: "Num Days",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a plan name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              SizedBox(height: 25),
              CustomTextForm(
                hintText: "Restaurant Names",
                controller: controller.restaurantNames,
                labelText: "Restaurant Names",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter restaurant names';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              CustomTextForm(
                hintText: "Hotel Names",
                controller: controller.hotelNames,
                labelText: "Hotel Names",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter hotel names';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              CustomTextForm(
                hintText: "Place Names",
                controller: controller.placeNames,
                labelText: "Place Names",
                isPassword: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter place names';
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              Obx(() => CustomMaterialButton(
                    buttonText:
                        controller.isLoading.value ? 'Loading...' : 'Save Plan',
                    onPressed: () async {
                      await controller.createPlan();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
