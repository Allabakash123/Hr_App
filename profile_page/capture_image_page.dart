

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/profile_page/profile_page_widget.dart';
import 'package:team_c/utils/helpers/helper_function.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/utils/const_api.dart';

class CapturePreviewPage extends StatefulWidget {
  final Uint8List imageBytes;
  final String username;

  const CapturePreviewPage({super.key, required this.imageBytes, required this.username});

  @override
  _CapturePreviewPageState createState() => _CapturePreviewPageState();
}

class _CapturePreviewPageState extends State<CapturePreviewPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        title: const Text('Preview & Edit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Container
              Container(
                height: THelperFunctions.screenHeight()*4, // 6 cm in pixels
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.grey, width: 2.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.memory(
                    widget.imageBytes,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Edit Icon Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color for the edit icon
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Next Button
                  FFButtonWidget(
                    onPressed: _isLoading
                        ? null
                        : () {
                            _saveImage(context, widget.username, widget.imageBytes);
                          },
                    text: _isLoading ? 'Saving...' : 'Next',
                   options: FFButtonOptions(
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).black,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                          ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ), loadingIndicatorColor:  Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveImage(BuildContext context, String username, Uint8List imageBytes) async {
    setState(() {
      _isLoading = true;
    });

    final token = await _getAuthToken();

    try {
      String imageData = base64Encode(imageBytes);
      final response = await http.put(
        Uri.parse('$apiBaseUrl/hr/api/user_details/edit_image'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'image_data': imageData}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User image updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        final token = await _getAuthToken();
        if (token != null) {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePageWidget(token: token),
            ),
          );
        }
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User image update failed'),
            backgroundColor: Colors.red,
          ),
        );
        final token = await _getAuthToken();
        if (token != null) {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePageWidget(token: token),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}

