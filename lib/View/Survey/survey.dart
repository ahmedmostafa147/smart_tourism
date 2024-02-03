import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/widget/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:smart_tourism/widget/Custom%20Material%20Button/custom_material_button.dart';

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
    'Wellness',
    'Religious',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tourism Preferences'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Your Preferred Types of Tourism',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
              SizedBox(height: 20.0),
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
              SizedBox(height: 20.0),
              CustomMaterialButton(
                  buttonText: "Submit",
                  onPressed: () {
                    Get.off(BottomNavBar());
                    print('Selected Types: $selectedTypes');
                  }),
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
