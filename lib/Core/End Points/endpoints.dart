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
}
