import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> getRecommendations(
    String location, List<String> surveyResponses) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.3:5000/recommend'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body:
        jsonEncode({'location': location, 'survey_responses': surveyResponses}),
  );

  if (response.statusCode == 200) {
    // Parse the response and extract recommendations
    final List<dynamic> data = jsonDecode(response.body)['recommendations'];
    return List<Map<String, dynamic>>.from(data);
  } else {
    // Handle errors
    throw Exception('Failed to load recommendations');
  }
}

Future<void> fetchAndDisplayRecommendations() async {
  final location = "Egypt";
  final surveyResponses = [
    "Tours",
    "Archaeological tourism",
    "Religious Tourism",
    "for fun",
    "Museums",
    "malls",
    "Natural views"
  ];

  try {
    final recommendations = await getRecommendations(location, surveyResponses);
    // Update UI with recommendations
    print("Recommendations: $recommendations");
  } catch (e) {
    // Handle errors
    print("Error fetching recommendations: $e");
  }
}
