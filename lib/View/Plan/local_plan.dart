import 'package:flutter/material.dart';

class localPlan extends StatelessWidget {
  const localPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Create your next trip by self!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text("Choose Country: "),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              items: <String>['Egypt', 'USA', 'France', 'Italy']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            Text("Choose Governorate: "),
            DropdownButton(
              items: <String>['Alexandria', 'Cairo', 'Giza', 'Luxor']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16.0),
            Text("num_days : "),
            SizedBox(height: 16.0),
            DropdownButton(
              items: <int>[1, 2, 3, 4, 5].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            Text("budget : "),
            DropdownButton(
              items: <int>[1000, 2000, 3000, 4000, 5000].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Get Recommendations'),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
