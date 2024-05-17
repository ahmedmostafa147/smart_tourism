import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContainerRecentSearch extends StatelessWidget {
  const ContainerRecentSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        children: [
          RecentSearchItem(text: 'Cairo'.tr),
          RecentSearchItem(text: 'Luxor'.tr),
          RecentSearchItem(text: 'Egypt'.tr),
        ],
      ),
    );
  }
}

class RecentSearchItem extends StatelessWidget {
  final String text;

  const RecentSearchItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }
}
