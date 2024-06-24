import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/View/Plan/history_plan.dart';
import 'package:smart_tourism/View/Plan/user_history_plan.dart';
import 'user_plan.dart';
import 'model_screen.dart';
import '../../Core/constants/images.dart';

class HistorySelectPlan extends StatefulWidget {
  @override
  State<HistorySelectPlan> createState() => _HistorySelectPlan();
}

class _HistorySelectPlan extends State<HistorySelectPlan> {
  @override
  Widget build(BuildContext context) {
    List<String> selectedTypes = [];

    final List<String> tourismTypes = [
      'AI History'.tr,
      'You History'.tr,
    ];
    List<Image> tourismImages = [
      Image.asset(Assets.imagesRoboticsamico),
      Image.asset(Assets.imagesInspirationpana),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan History'.tr),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What History do you want to See'.tr,
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.0),
              // Display GridView with tourism types
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: tourismTypes.length,
                itemBuilder: (context, index) {
                  return TourismTypeItem(
                    image: tourismImages[index],
                    type: tourismTypes[index],
                    isSelected: selectedTypes.contains(tourismTypes[index]),
                    onTap: () {
                      setState(() {
                        if (selectedTypes.contains(tourismTypes[index])) {
                          selectedTypes.remove(tourismTypes[index]);
                        } else {
                          selectedTypes.add(tourismTypes[index]);
                        }
                        if (tourismTypes[index] == 'AI History'.tr) {
                          Get.to(() =>
                              SavedPlansScreen()); // Navigate to recommendation screen
                        }
                        if (tourismTypes[index] == 'You History'.tr) {
                          Get.to(() =>
                              UserHistoryPlansScreen()); // Navigate to model screen
                        }
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 20.0.h),
              Divider(),
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
  final Image image;

  const TourismTypeItem({
    required this.type,
    required this.isSelected,
    required this.onTap,
    required this.image,
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
        child: Column(
          children: [
            SizedBox(height: 100.h, child: image),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
