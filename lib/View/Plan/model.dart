import 'package:flutter/material.dart';
import '../../Core/Service/model_integration.dart';

class RecommendationScreen extends StatefulWidget {
  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  List<Map<String, dynamic>> recommendations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAndDisplayRecommendations();
  }

  Future<void> fetchAndDisplayRecommendations() async {
    final location = "Egypt";
    final surveyResponses = ["Tours", "for fun", "Museums", "Natural views"];

    try {
      final fetchedRecommendations =
          await getRecommendations(location, surveyResponses);
      setState(() {
        recommendations = fetchedRecommendations;
        isLoading = false;
      });
    } catch (e) {
      // Handle errors
      print("Error fetching recommendations: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : recommendations.isNotEmpty
              ? ListView.builder(
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recommendations[index]['Title']),
                      subtitle:
                          Text('Price: ${recommendations[index]['Price']}'),
                    );
                  },
                )
              : Center(
                  child: Text('No recommendations available.'),
                ),
    );
  }
}
