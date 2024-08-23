
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/ForgotPassword/email_verification.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';
import 'package:team_c/utils/helpers/helper_function.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class AccountRecoveryWidget extends StatefulWidget {
  const AccountRecoveryWidget({Key? key}) : super(key: key);

  @override
  State<AccountRecoveryWidget> createState() => _AccountRecoveryWidgetState();
}

class _AccountRecoveryWidgetState extends State<AccountRecoveryWidget> {
  String selectedEmail = '';
  List<String> emails = [];
  String phoneNumber = '';
  String whatsAppNumber = '';
  String username = '';
  bool isLoading = false;

  final TextEditingController _usernameController = TextEditingController();

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

  String hidePhoneNumber(String phoneNumber) {
    if (phoneNumber.isNotEmpty && phoneNumber.length >= 8) {
      return '*****${phoneNumber.substring(phoneNumber.length - 3)}';
    }
    return phoneNumber;
  }

  String hideWhatsAppNumber(String whatsAppNumber) {
    if (whatsAppNumber.isNotEmpty && whatsAppNumber.length >= 8) {
      return '*****${whatsAppNumber.substring(whatsAppNumber.length - 3)}';
    }
    return whatsAppNumber;
  }

  Future<void> fetchDetails(String username) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.11:8000/hr/api/public_user_details?username=$username'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String email = data['email'] ?? '';
        final String phone = data['phone_number'] ?? '';
        final String whatsApp = data['whatsapp_number'] ?? '';
        setState(() {
          emails = [email];
          selectedEmail = email;
          phoneNumber = phone;
          whatsAppNumber = whatsApp;
        });
      } else {
        print('Failed to load details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> sendOTPEmail(String email) async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/hr/api/send_otp_email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'subject': 'Account Recovery OTP',
          'recipients': email,
          'message':
              'Your OTP is:', // Adjusted to fit the backend message format
        }),
      );

      if (response.statusCode == 200) {

        print('OTP email sent successfully');
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EmailVerificationScreen(
            email: email,
            otp: null,
          ),
        ));
      } else if (response.statusCode == 422) {
        print('Unprocessable Entity: ${response.body}');
      } else {
        print('Failed to send OTP email. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending OTP email: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Account Recovery',
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
          child: SingleChildScrollView(
            child: Container(
              width: THelperFunctions.screenWidth()*2.0,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Recovery',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Raleway',
                          color: FlutterFlowTheme.of(context).oxfordBlue,
                          fontSize: TSizes.fontSizeMd*1.5,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'To help keep your account safe, we need to make sure it’s really you trying to sign in.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Raleway',
                          color: FlutterFlowTheme.of(context).black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Enter your username',
                      labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize:14),
                      hintText: 'Enter your username',
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
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: FFButtonWidget(
                      onPressed: () {
                        fetchDetails(_usernameController.text);
                      },
                      text: 'Fetch Details',
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                       color: FlutterFlowTheme.of(context).oxfordBlue,
                        textStyle:
                            // ignore: deprecated_member_use_from_same_package
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Raleway',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      loadingIndicatorColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  if (isLoading) const CircularProgressIndicator(),
                  if (!isLoading && selectedEmail.isNotEmpty) ...[
                    Text(
                      'Choose how you want to sign in:',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).black,
                            fontSize: 16.0,
                          ),
                    ),
                    const SizedBox(height: 20.0),
                    buildRecoveryOption(
                      context,
                      'Get a verification code at ${hideEmail(selectedEmail)}',
                      Icons.email,
                      () {
                        sendOTPEmail(selectedEmail);
                      },
                    ),
                    const SizedBox(height: 10.0),
                    buildRecoveryOption(
                      context,
                      'Get a verification code at ${hidePhoneNumber(phoneNumber)}',
                      Icons.phone,
                      () {
                        // Call the function to send OTP and navigate
                      },
                    ),
                   
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecoveryOption(BuildContext context, String text, IconData icon,
      VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: FlutterFlowTheme.of(context).oxfordBlue),
      label: Expanded(
        child: Text(
          text,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).oxfordBlue,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        side: const BorderSide(
          color: Colors.black26,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        elevation: 0.0,
      ),
    );
  }
}
