import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Core/constants/images.dart';

class ContainerOPtionsSearch extends StatelessWidget {
  const ContainerOPtionsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOptionsWidget();
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
                label: 'Restaurant'.tr),
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesBedAlt)),
                label: 'Hotel'.tr),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesBuilding)),
                label: 'Places'.tr),
            CustomOption(
                icon: ImageIcon(AssetImage(Assets.imagesBallot)),
                label: 'To Do List'.tr),
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
      width: 160.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.teal[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
