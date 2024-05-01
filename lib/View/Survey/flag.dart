import 'package:flutter/material.dart';

class ContainerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 14,
      itemBuilder: (context, index) {
        return CustomContainer(index: index);
      },
    );
  }
}

class CustomContainer extends StatelessWidget {
  final int index;

  CustomContainer({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.teal,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            Icons.flag,
            color: Colors.teal,
            size: 30.0,
          ),
          SizedBox(width: 10.0),
          Text(
            'Country Name ${index + 1}',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
