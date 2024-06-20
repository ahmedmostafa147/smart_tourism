class ApiEndPoints {
  static final String baseUrl = 'https://zoz-rwob.onrender.com/';

  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'register';
  final String loginEmail = 'login';
  final String deleteEmail = 'delete';
  final String logoutEmail = 'logout';
  final String UpdateProfile = 'update';
  final String resetPassword = 'reset_password';
  final String changePassword = 'change_password';
  final String loginGoogle = 'login_google';
  final String search = 'search';
  final String recentSearches = 'recent_searches';
  final String mayLikedItems = 'may liked it';
  final String getProfile = 'protected';
  final String createPlan = 'create_plan';
  final String historyPlans = 'history plans';
  final String favorites = 'favorites';
  final String deleteFavorite = 'favorites';
  final String deletePlan = 'delete_plan';
  final String updatePlan = 'update';
  final String survey = 'survey/';
  final String outputSurvey = 'survey_responses';
  final String recommendations = 'recommendations/';
  final String outputRecommendations = 'output_recommendations/';
  final String QuestionChat = "chat_questions/";
  final String ResponseChat = "chat_responses/";
  final String getChatHistoryQuestion = "output_questions/";
  final String getChatHistoryResponse = "output_responses/";
  final String discover_places = "discover_places/";
  final String discover_Hotels = "discover_hotels/";
  final String discover_Restaurants = "discover_restaurants/";
}
