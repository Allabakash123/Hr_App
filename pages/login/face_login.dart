// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for SystemNavigator
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/app_state.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/pages/login/login_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';

class FaceLogin extends StatefulWidget {
  const FaceLogin({Key? key}) : super(key: key);

  @override
  State<FaceLogin> createState() => _FaceLoginState();
}

class _FaceLoginState extends State<FaceLogin> {
  late CameraController? _controller;
  late Uint8List? _capturedImageBytes;
  bool _isControllerInitialized = false;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _selectedCameraIndex = _cameras.indexWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      if (_selectedCameraIndex == -1) {
        _selectedCameraIndex =
            0; // Fallback to the first camera if no front camera is found
      }
      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.max,
      );

      await _controller!.initialize();
      setState(() {
        _isControllerInitialized = true;
      });
    }
  }

  void _flipCamera() {
    if (_cameras.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.max,
      );
      _controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  Future<void> _captureImage() async {
    try {
      XFile imageFile = await _controller!.takePicture();
      Uint8List bytes = await imageFile.readAsBytes();
      setState(() {
        _capturedImageBytes = bytes;
      });
      String base64Image = base64Encode(bytes);
      print("Captured Image Base64: $base64Image");
      await _sendImageToServer(base64Image);
    } catch (e) {
      print("Error capturing image: $e");
      Fluttertoast.showToast(msg: 'Failed to capture image');
    }
  }

  Future<void> _sendImageToServer(String base64Image) async {
    try {
      var uri = Uri.parse('$apiBaseUrl/hr/api/loginFace');
      var requestBody = jsonEncode({
        'image_data': base64Image,
      });

      print("Sending image to server...");

      http.Response response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body.toString());
        var myToken = responseData['token'];
        print("API Response: $responseData");

        if (responseData['authenticated'] == true) {
          print("Authentication successful");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Face Login is successfully'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
          await prefs.setString('token', myToken);

          print("Navigating to EmployeePage...");

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => EmployepageWidget(token: myToken)),
            (Route<dynamic> route) => false,
          );
        } else {
          print("Authentication failed");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to Login. Please try again.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        print(
            "Failed to authenticate with status code: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to Login. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print("Error sending image to server: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to Login. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isControllerInitialized ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Face Login'),
          backgroundColor: Colors.black,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        // Close the app
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Face Login',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20),
          ),
          backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginWidget()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.flip_camera_android),
              onPressed: _flipCamera,
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Note: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: TSizes.fontSizeMd*1.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Please look at the camera carefully until login is successful.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize:TSizes.fontSizeSm*1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: 200,
                  child: CameraPreview(_controller!),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FFButtonWidget(
                    onPressed: _captureImage,
                    text: 'LOGIN',
                    options: FFButtonOptions(
                      width: TSizes.buttonWidth*1.5,
                      height:TSizes.buttonHeight*3,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      iconPadding: const EdgeInsets.all(0.0),
                      color: FlutterFlowTheme.of(context).oxfordBlue,
                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Poppins',
                            color:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            fontSize: TSizes.fontSizeLg,
                            fontWeight: FontWeight.bold,
                          ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    loadingIndicatorColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
