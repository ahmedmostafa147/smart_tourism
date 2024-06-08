import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controller/model_ai_controller.dart';

class RecommendationScreen extends StatelessWidget {
  final ModelAIController controller = Get.put(ModelAIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'AI Will Make Recommendations for your next trip!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
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
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      await controller.getRecommendations();
                    }
                  },
                  child: Obx(
                    () => Text(controller.isLoading.value
                        ? 'Loading...'
                        : 'Get Recommendations'),
                  )),
              SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.recommendations.length,
                        itemBuilder: (context, index) {
                          final recommendation =
                              controller.recommendations[index];
                          return Card(
                            child: ListTile(
                              title: Text(recommendation.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: ${recommendation.price}'),
                                  Text('Tags: ${recommendation.tags}'),
                                  Text(
                                      'Governorate: ${recommendation.governorate}'),
                                  Text('Day: ${recommendation.day}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
