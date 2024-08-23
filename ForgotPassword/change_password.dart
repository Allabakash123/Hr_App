

import 'package:flutter/material.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:team_c/pages/login/login_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';
import 'package:team_c/utils/helpers/helper_function.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String email;

  ChangePasswordScreen({required this.email});

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _updatePassword(BuildContext context) async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final Map<String, String> requestBody = {
      'email': email,
      'new_password': newPassword,
    };

    final response = await http.post(
      Uri.parse('$apiBaseUrl/hr/api/update-password'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    // Dismiss loading dialog
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      // Initialize Flutter TTS
      FlutterTts flutterTts = FlutterTts();

      // Speak the success message
      await flutterTts.speak('Your password is successfully updated!');

      // Navigate to LoginWidget
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWidget()),
      );
    } else {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['error'] ?? 'An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
   backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Forgot Password',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Raleway',
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: THelperFunctions.screenWidth()*3,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create a Strong Password',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Raleway',
                          color: FlutterFlowTheme.of(context).oxfordBlue,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize:14),
                        hintText: 'New Password',
                                     hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(height: 10.0), // Adjusted height
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize:14),
                        hintText: 'Confirm Password',
                                     hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  FFButtonWidget(
                    onPressed: () => _updatePassword(context),
                    text: 'Save Password',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      color: FlutterFlowTheme.of(context).oxfordBlue,
                      textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: TSizes.fontSizeMd*1.2,
                            fontWeight: FontWeight.bold,
                          ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ), 
                    loadingIndicatorColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
