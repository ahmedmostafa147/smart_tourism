import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/constants/images.dart';
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
            Assets.images1mus,
            Assets.images2mus,
            Assets.images5mus,
            Assets.images4mus,
            Assets.images9mus,
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
                      imagePaths[index],
                      fit: BoxFit.cover,
                      width: 250.w,
                      height: 230.h,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
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
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage(
                                  Assets.imagesMenu,
                                ),
                                size: 20.r,
                                color: Colors.black,
                              ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  ImageIcon(
                                    AssetImage(
                                      Assets.imagesMenu,
                                    ),
                                    size: 20.r,
                                    color: Colors.black,
                                  ),
                          )
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

class ContainerDisplayRes extends StatefulWidget {
  const ContainerDisplayRes({super.key});

  @override
  State<ContainerDisplayRes> createState() => _ContainerDisplayResState();
}

class _ContainerDisplayResState extends State<ContainerDisplayRes> {
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
            Assets.images8res,
            Assets.images2res,
            Assets.images5res,
            Assets.images4res,
            Assets.images9res,
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
                      imagePaths[index],
                      fit: BoxFit.cover,
                      width: 250.w,
                      height: 230.h,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "5km".tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                            IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage(
                                  Assets.imagesMenu,
                                ),
                                size: 20.r,
                                color: Colors.black,
                              ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  ImageIcon(
                                    AssetImage(
                                      Assets.imagesMenu,
                                    ),
                                    size: 20.r,
                                    color: Colors.black,
                                  ),
                          )
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
class ContainerDisplayHot extends StatefulWidget {
  const ContainerDisplayHot({super.key});

  @override
  State<ContainerDisplayHot> createState() => _ContainerDisplayHotState();
}

class _ContainerDisplayHotState extends State<ContainerDisplayHot> {
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
            Assets.images8hot,
            Assets.images2hot,
            Assets.images5hot,
            Assets.images4hot,
            Assets.images9hot,
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
                      imagePaths[index],
                      fit: BoxFit.cover,
                      width: 250.w,
                      height: 230.h,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
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
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                           IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage(
                                  Assets.imagesMenu,
                                ),
                                size: 20.r,
                                color: Colors.black,
                              ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  ImageIcon(
                                    AssetImage(
                                      Assets.imagesMenu,
                                    ),
                                    size: 20.r,
                                    color: Colors.black,
                                  ),
                          )
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
