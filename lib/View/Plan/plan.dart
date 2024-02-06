import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Home/widgets/container_display_nearest.dart';
import '../Search/Search.dart';
import '../../widget/BottomNavigationBar/bottom_navigation_bar.dart';
import '../../widget/Custom%20Material%20Button/custom_material_button.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    List<String> selectedTypes = [];

    final List<String> tourismTypes = [
      'AI',
      'You',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select What you want to do your plan',
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
              SizedBox(height: 20.0),
              Text("This is the best plan from AI",
                  style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w400,
                     )),
              ContainerDisplayNearestHome(),
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
            type,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
