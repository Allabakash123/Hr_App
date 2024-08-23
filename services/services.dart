import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:team_c/utils/const_api.dart';

class ApiService {
  static const String baseUrl = '$apiBaseUrl/api/register'; // Replace with your API base URL

  Future<bool> signUp(String username, String password, Uint8List imageBytes) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        body: {
          'username': username,
          'password': password,
          'image': base64Encode(imageBytes),
        },
      );

      if (response.statusCode == 200) {
        // Successful sign-up
        return true;
      } else {
        // Sign-up failed
        print('Sign-up failed: ${response.body}');
        return false;
      }
    } catch (e) {
      // Error occurred during sign-up
      print('Error during sign-up: $e');
      return false;
    }
  }
}
