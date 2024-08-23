
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/ForgotPassword/change_password.dart';
import 'package:team_c/utils/const_api.dart';
import 'dart:convert';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

String hideEmail(String email) {
  if (email.isNotEmpty) {
    final atIndex = email.indexOf('@');
    if (atIndex > 3) {
      final maskedPart = List.filled(atIndex - 3, '•').join('');
      return email.replaceRange(3, atIndex, maskedPart);
    }
  }
  return email;
}

class EmailVerificationScreen extends StatefulWidget {
  final String email;

  EmailVerificationScreen({required this.email, required otp});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  Future<void> _validateOtp() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(
          '$apiBaseUrl/hr/api/validate_otp'), // Replace with your API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.email,
        'otp': _otpController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['message'] == 'OTP validated successfully') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangePasswordScreen(email: widget.email)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  responseBody['error'] ?? 'Invalid OTP. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP time out. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Account Recovery',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
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
            width: 600,
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
                    'Verify Your Account',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).oxfordBlue,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'An email with a verification code was just sent to ${hideEmail(widget.email)}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.of(context).black,
                          fontSize: 16.0,
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    
                    controller: _otpController,
                    decoration: InputDecoration(
                      labelText: 'Enter code',
                      labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize:14),
                        hintText: 'Enter your username',
                                     hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).black,
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
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : FFButtonWidget(
                          onPressed: _validateOtp,
                          text: 'Next',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            color: FlutterFlowTheme.of(context).oxfordBlue,
                            textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                               fontSize: 16.0,
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
                  const SizedBox(height: 10.0),
                  FFButtonWidget(
                    onPressed: () {
                      // Handle try another way logic
                    },
                    text: 'Try another way',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      color: FlutterFlowTheme.of(context).white,
                      textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).black,
                        width: 2,
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
