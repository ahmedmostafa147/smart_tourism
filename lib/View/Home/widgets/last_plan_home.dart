import 'package:flutter/material.dart';

class LastPlan extends StatelessWidget {
  const LastPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Last Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'View All',
              style: TextStyle(
                fontSize: 17,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        // Container(
        //   height: 200,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 5,
        //     itemBuilder: (context, index) {
        //       return Column(
        //         children: [
        //           Flexible(
        //             child: Container(
        //               margin: EdgeInsets.all(10),
        //               width: 150,
        //               decoration: BoxDecoration(
        //                 color: Colors.grey,
        //                 borderRadius: BorderRadius.circular(10),
        //               ),
        //               child: Flexible(
        //                 child: Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.only(
        //                       topLeft: Radius.circular(10),
        //                       topRight: Radius.circular(10),
        //                     ),
        //                     image: DecorationImage(
        //                       image: AssetImage(Assets.images1hot),
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           Text(
        //             'Magic Tower',
        //             style: TextStyle(
        //               fontSize: 12,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
