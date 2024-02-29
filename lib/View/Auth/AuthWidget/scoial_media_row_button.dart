
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'social_media_button.dart';


class socialMediaRowButtoms extends StatelessWidget {
   socialMediaRowButtoms({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.facebook, color: Colors.blue)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.apple, color: Colors.black)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: ()async {
                
                },
                icon: const Icon(Icons.g_mobiledata_sharp, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
