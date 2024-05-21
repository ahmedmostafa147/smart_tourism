import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widget/BottomNavigationBar/bottom_navigation_bar.dart';
import '../../widget/Custom%20Material%20Button/custom_material_button.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  List<String> selectedTypes = [];

  final List<String> tourismTypes = [
    'Adventure',
    'Cultural',
    'Beach',
    'Historical',
    'Nature',
    'Shopping',
    'Relaxation',
    'Urban',
    'Culinary',
    'Wildlife',
    'Mountain',
    'Safari',
  ];

  Future<void> saveSurvey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('survey', selectedTypes);
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
                  SizedBox(height: 20.0.sp),
                  // Display GridView with tourism types
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
              CustomMaterialButton(
                buttonText: "Submit".tr,
                onPressed: () async {
                  await saveSurvey();
                  Get.off(NavBar());
                },
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            type.tr,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.0.sp,
            ),
          ),
        ),
      ),
    );
  }
}
