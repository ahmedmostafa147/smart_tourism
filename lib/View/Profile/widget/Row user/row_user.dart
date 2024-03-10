import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/constants/images.dart';

class RowUser extends StatelessWidget {
  const RowUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.teal, width: 2.w, style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Image.asset(
                    Assets.imagesProfile,
                    width: 40.h,
                    height: 40.w,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text("Ahmed Mostafa", style: TextStyle(fontSize: 15.sp)),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Colors.teal, width: 2.w, style: BorderStyle.solid),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Egypt',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
