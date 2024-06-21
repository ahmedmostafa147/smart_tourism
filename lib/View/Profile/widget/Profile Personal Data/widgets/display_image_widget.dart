import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_tourism/Core/constants/images.dart';

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
            right: 4,
            bottom: 10,
            child: GestureDetector(
              onTap: onPressed,
              child: buildEditIcon(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    return CircleAvatar(
      backgroundImage: imagePath.isNotEmpty
          ? NetworkImage(imagePath) as ImageProvider
          : AssetImage(Assets.imagesCircleUser),
      radius: 80.r,
    );
  }

  Widget buildEditIcon() => buildCircle(
        all: 8,
        child: Icon(
          Icons.camera_alt_outlined,
          color: Colors.teal,
          size: 30.r,
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.white,
          child: child,
        ),
      );
}
