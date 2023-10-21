import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_tourism/presentation/widget/SocialMediaButtom.dart';

class socialMediaRowButtoms extends StatelessWidget {
  const socialMediaRowButtoms({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon:
                    const Icon(FontAwesomeIcons.facebook, color: Colors.blue)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.apple, color: Colors.black)),
          ),
          const Spacer(),
          SocialMediaButton(
            IconName: IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.google, color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
