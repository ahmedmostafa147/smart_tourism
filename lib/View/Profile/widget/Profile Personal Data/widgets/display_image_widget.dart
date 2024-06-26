import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_tourism/Core/constants/images.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            right: 1,
            bottom: 11,
            child: GestureDetector(
              onTap: onPressed,
              child: buildEditIcon(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return CircleAvatar(
      radius: 40.r,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imagePath,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset(
            Assets.imagesCircleUser,
            width: 60.h,
            height: 60.h,
            fit: BoxFit.contain,
            color: Colors.teal,
          ),
          imageBuilder: (context, imageProvider) => Container(
            width: 60.h,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon() => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.teal,
            size: 10.r,
          ),
        ),
      );
}
