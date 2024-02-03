import 'package:flutter/material.dart';
import 'package:smart_tourism/View/Home/home.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Where to?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            
            
           
            SizedBox(height: 10),
            Text(
              'Your Recent Searches',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RecentSearchItem(text: 'Cairo'),
                  RecentSearchItem(text: 'Luxor'),
                  RecentSearchItem(text: 'Aswan'),
                  // Add more RecentSearchItem widgets as needed
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.red,
              // Add content to the red square container as needed
            ),
    
            
          ],
        ),
      ),
    );
  }
}

class RecentSearchItem extends StatelessWidget {
  final String text;

  const RecentSearchItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text),
    );
  }
}