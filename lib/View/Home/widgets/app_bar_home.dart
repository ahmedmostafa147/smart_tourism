import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Auth/Login/login.dart';
import '../../../constants/images.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarHome({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: ImageIcon(
              AssetImage(
                Assets.imagesMenu,
              ),
              size: 35.r,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.pin_drop_outlined,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'Egypt',
                style: TextStyle(fontSize: 16.sp),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
              )
            ],
          ),
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
        ],
      ),
      actions: [
        IconButton(
          onPressed: () async {
           

            Get.offAll(() =>  LoginView());
          },
          icon: Icon(
            Icons.logout,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
          ),
        )
      ],
    );
  }
}
