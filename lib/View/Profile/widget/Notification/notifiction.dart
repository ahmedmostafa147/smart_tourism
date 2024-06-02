import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: Colors.teal,
      ),
      height: 150.h,
      width: double.infinity,
      child: Column(
        children: [
          Center(
            child: Text('Notification'),
          ),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
              Text('Get Notification on your device'),
              Icon(Icons.notifications),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
              Text('Feedback Notification'),
              Icon(Icons.notifications),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
              Row(
                children: [
                  Text('Update Notification'),
                ],
              ),
              Icon(Icons.notifications),
            ],
          ),
        ],
      ),
    );
  }
}
