import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/images.dart';

class ContainerOPtionsSearch extends StatelessWidget {
  const ContainerOPtionsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.h,
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.teal, width: 1.0),
        ),
        child: CustomOptionsWidget());
  }
}

class CustomOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesRestaurant)),
                label: 'Restaurant'),
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesBedAlt)),
                label: 'Hotel'),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesBuilding)),
                label: 'Places'),
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesBallot)),
                label: 'To Do List'),
          ],
        ),
      ],
    );
  }
}

class CustomOption extends StatelessWidget {
  final ImageIcon icon;
  final String label;

  const CustomOption({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.teal[300],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10.w,
            ),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 17.0.sp),
            ),
          ],
        ),
      ),
    );
  }
}
