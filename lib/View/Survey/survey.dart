import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';
import 'package:smart_tourism/Core/constants/font.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final List<String> tourismTypes = [
    'Tours',
    'Archaeological tourism',
    'for fun',
    'Religious Tourism',
    'parks',
    'Museums',
    'malls',
    'games',
    'Natural views',
    'water places',
  ];

  List<String> selectedTypes = [];
  final SurveySaveController surveyController = Get.put(SurveySaveController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourism Preferences'.tr),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Your Preferred Types of Tourism'.tr,
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: tourismTypes.length,
                    itemBuilder: (context, index) {
                      return TourismTypeItem(
                        type: tourismTypes[index],
                        isSelected: selectedTypes.contains(tourismTypes[index]),
                        onTap: () {
                          setState(() {
                            if (selectedTypes.contains(tourismTypes[index])) {
                              selectedTypes.remove(tourismTypes[index]);
                            } else {
                              selectedTypes.add(tourismTypes[index]);
                            }
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.0.h),
                ],
              ),
              Obx(
                () => surveyController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : CustomMaterialButton(
                        buttonText: "Submit".tr,
                        onPressed: () async {
                          if (selectedTypes.isEmpty) {
                            Get.snackbar(
                              'Error'.tr,
                              'Please select at least Two type of tourism'.tr,
                            );
                            return;
                          } else {
                            surveyController.submitSurvey(selectedTypes);
                          }
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

class TourismTypeItem extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const TourismTypeItem({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            type.tr,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14.sp,
                fontFamily: TextFontStyle.Mano),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
