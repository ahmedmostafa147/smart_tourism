import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../Core/End%20Points/endpoints.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final String? idToken = googleSignInAuthentication.idToken;
        final String? accessToken = googleSignInAuthentication.accessToken;
        if (idToken != null && accessToken != null) {
          var url = Uri.parse(
              ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginGoogle);
          // Send idToken and accessToken to your backend API
          final response = await http.put(
            url,
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode(<String, String>{
              'id_token': idToken,
              'access_token': accessToken
            }),
          );

          if (response.statusCode == 200) {
            // Successful login with Google
            Get.snackbar('Success', 'Logged in with Google');
          } else {
            throw 'Failed to log in with Google: ${response.statusCode}';
          }
        } else {
          throw 'Failed to obtain ID token or access token';
        }
      } else {
        throw 'Google sign in cancelled';
      }
    } catch (error) {
      Get.snackbar('Error', error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
