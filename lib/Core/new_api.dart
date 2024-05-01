import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchedData extends StatefulWidget {
  @override
  _FetchedDataState createState() => _FetchedDataState();
}

class _FetchedDataState extends State<FetchedData> {
  List<Map<String, dynamic>> recommendations = [];

  Future<void> fetchRecommendations() async {
    final String apiUrl = 'http://10.0.2.2:5000/recommendations/';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'country': 'Egypt',
        'governorate': 'Alexandria',
        'survey_responses': [
          'Museums',
          'water places',
          'for fun',
          'Archaeological tourism',
          'Religious Tourism',
          'malls ',
          'parks',
          'Tours',
          'Natural views'
        ],
        'num_days': 3,
        'budget': 100000.0,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response body (assuming it's JSON)
      final responseData = jsonDecode(response.body);
      setState(() {
        recommendations = List<Map<String, dynamic>>.from(responseData);
      });
    } else {
      // Handle errors
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchRecommendations,
              child: Text('Fetch Data'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recommendations.length,
                itemBuilder: (context, index) {
                  final recommendation = recommendations[index];
                  return ListTile(
                    title: Text(recommendation['Title']),
                    subtitle: Text('Price: ${recommendation['Price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
