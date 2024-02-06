import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/images.dart';
import 'det.dart';

class ContainerDisplayNearestHome extends StatefulWidget {
  const ContainerDisplayNearestHome({super.key});

  @override
  State<ContainerDisplayNearestHome> createState() =>
      _ContainerDisplayNearestHomeState();
}

class _ContainerDisplayNearestHomeState
    extends State<ContainerDisplayNearestHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 250.h,
      child: ListView.builder(
        itemCount: 5,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          List<String> imagePaths = [
            Assets.imagesImg1,
            Assets.imagesImg2,
            Assets.imagesImg3,
            Assets.imagesImg4,
            Assets.imagesImg5,
          ];

          return Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailView(id: index)));
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    child: Image.asset(
                        imagePaths[index]), // Use the image path from the list
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.71),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "5km",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.heart)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.list)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
