// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowOptions extends StatelessWidget {
  final String text;
  final ImageIcon IconName;
  final Function() onTap;
  RowOptions({
    Key? key,
    required this.text,
    required this.IconName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              ImageIcon(
                IconName.image,
                size: 20.r,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              SizedBox(
                width: 8.0.w,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 17.sp),
              ),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.arrow_forward_ios_outlined, color: Colors.teal),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
