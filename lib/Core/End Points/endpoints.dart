class ApiEndPoints {
  static final String baseUrl = 'https://smart-tourism-mjyq.onrender.com/';
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
  final String getProfile = 'protected';
}
