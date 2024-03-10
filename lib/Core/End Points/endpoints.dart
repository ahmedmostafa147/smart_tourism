class ApiEndPoints {
  static final String baseUrl = 'http://52.90.144.144:8080/';
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
