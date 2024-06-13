import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/plan_controller/create_plan_controller.dart';

class LocalPlanScreen extends StatelessWidget {
  final PlanController controller = Get.put(PlanController());

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
            Text("Country: "),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return controller.countries;
                }
                return controller.countries.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                controller.countryController.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                fieldFocusNode.addListener(() {
                  if (fieldFocusNode.hasFocus &&
                      fieldTextEditingController.text.isEmpty) {
                    fieldTextEditingController.text = " ";
                    Future.delayed(Duration.zero, () {
                      fieldTextEditingController.clear();
                    });
                  }
                });
                controller.countryController.value =
                    fieldTextEditingController.value;
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter country name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a country name';
                    }
                    return null;
                  },
                );
              },
            ),
            SizedBox(height: 16.0),
            Text("Choose Governorate: "),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return controller.governorates;
                }
                return controller.governorates.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                controller.governorateController.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                fieldFocusNode.addListener(() {
                  if (fieldFocusNode.hasFocus &&
                      fieldTextEditingController.text.isEmpty) {
                    fieldTextEditingController.text = " ";
                    Future.delayed(Duration.zero, () {
                      fieldTextEditingController.clear();
                    });
                  }
                });
                controller.governorateController.value =
                    fieldTextEditingController.value;
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter governorate name',
                    suffixIcon: Icon(Icons.search),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a governorate name';
                    }
                    return null;
                  },
                );
              },
            ),
            SizedBox(height: 16.0),
            Text("Number of Days: "),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return controller.numDays;
                }
                return controller.numDays.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                controller.numDaysController.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                fieldFocusNode.addListener(() {
                  if (fieldFocusNode.hasFocus &&
                      fieldTextEditingController.text.isEmpty) {
                    fieldTextEditingController.text = " ";
                    Future.delayed(Duration.zero, () {
                      fieldTextEditingController.clear();
                    });
                  }
                });
                controller.numDaysController.value =
                    fieldTextEditingController.value;
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter number of days',
                    suffixIcon: Icon(Icons.search),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number of days';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                );
              },
            ),
            SizedBox(height: 16.0),
            Text("Budget: "),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return controller.budget;
                }
                return controller.budget.where((String option) {
                  return option
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                controller.budgetController.text = selection;
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                fieldFocusNode.addListener(() {
                  if (fieldFocusNode.hasFocus &&
                      fieldTextEditingController.text.isEmpty) {
                    fieldTextEditingController.text = " ";
                    Future.delayed(Duration.zero, () {
                      fieldTextEditingController.clear();
                    });
                  }
                });
                controller.budgetController.value =
                    fieldTextEditingController.value;
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter budget',
                    suffixIcon: Icon(Icons.search),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter budget';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
