import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_tourism/widget/BottomNavigationBar/bottom_navigation_bar.dart';

class GoogleSignInController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  var currentUser = Rx<GoogleSignInAccount?>(null);
  var isSignedIn = false.obs;
  var isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    // _checkSignInStatus();
  }

  // Future<void> _checkSignInStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? loggedIn = prefs.getBool('isLoggedIn');
  //   if (loggedIn == true) {
  //     await _googleSignIn.signInSilently();
  //     currentUser.value = _googleSignIn.currentUser;
  //     isSignedIn.value = true;
  //     Get.offAll(NavBar());
  //   } else {
  //     isSignedIn.value = false;
  //   }
  // }

  Future<void> signIn() async {
    try {
      isLoaded.value = false;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        currentUser.value = googleUser;
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        print(googleUser.email);
        print(googleUser.displayName);
        print(googleAuth.accessToken);
        print(googleUser.id);
        print(googleAuth.idToken);

        // Send the authentication token to the server to register the user
        final response = await _registerUserOnServer(
          googleUser.email,
          googleUser.displayName,
          googleUser.id,
          googleAuth.accessToken,
        );
        print('Response: ${response.body}');

        if (response.statusCode == 200) {
          // Successfully registered
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          isSignedIn.value = true;
          Get.offAll(NavBar());
        } else {
          // Handle server response errors
          print('Failed to register on server: ${response.body}');
        }
      } else {
        print('Google sign-in failed');
      }
    } catch (error) {
      print('Error during Google sign-in: $error');
    } finally {
      isLoaded.value = true;
    }
  }

  Future<http.Response> _registerUserOnServer(String email, String? displayName,
      String? accessToken, String? id) async {
    final url = Uri.parse(
        'https://your-server-url.com/api/register'); // Replace with your server URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'name': displayName,
        'accessToken': accessToken,
        'id': id,
      }),
    );
    return response;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    isSignedIn.value = false;
  }
}
