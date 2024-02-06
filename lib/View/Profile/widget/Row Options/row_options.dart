import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowOptions extends StatelessWidget {
  final String text;
  final ImageIcon IconName;
  const RowOptions({super.key, required this.text, required this.IconName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            ImageIcon(
              IconName.image,
              size: 20.sp,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15.sp),
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
