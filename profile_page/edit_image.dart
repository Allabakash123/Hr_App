
import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:team_c/profile_page/capture_image_page.dart';
import 'package:team_c/utils/constants/sizes.dart';
import 'package:team_c/utils/helpers/helper_function.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class MyCameraWidget extends StatefulWidget {
  final String username;

  const MyCameraWidget({super.key, required this.username});

  @override
  State<MyCameraWidget> createState() => _MyCameraWidgetState();
}

class _MyCameraWidgetState extends State<MyCameraWidget> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;
  List<CameraDescription> _cameras = [];
  Uint8List? _capturedImageBytes;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _selectedCameraIndex = _cameras.indexWhere((camera) => camera.lensDirection == CameraLensDirection.front);
        if (_selectedCameraIndex == -1) {
          _selectedCameraIndex = 0;
        }
        await _initCameraController(_cameras[_selectedCameraIndex]);
      }
    } catch (e) {
      print('Error initializing cameras: $e');
    }
  }

  Future<void> _initCameraController(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    _cameraController = CameraController(cameraDescription, ResolutionPreset.max);

    try {
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera controller: $e');
    }
  }

  void _flipCamera() {
    if (_cameras.length > 1) {
      setState(() {
        _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
        _isCameraInitialized = false;
      });
      _initCameraController(_cameras[_selectedCameraIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                 constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Edit Profile Image',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                      fontSize: TSizes.fontSizeMd*2.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
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
                                      text: 'Please take a photo in a well-lit area, Look at the camera carefully ensuring that the captured face is clear.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                           fontSize: TSizes.fontSizeMd*1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!_isCameraInitialized)
                          const Center(child: CircularProgressIndicator())
                        else
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                width: 250.0,
                                height: 320.0,
                                child: CameraPreview(_cameraController!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: const Icon(Icons.flip_camera_ios, color: Colors.black),
                                  onPressed: _flipCamera,
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                FFAppState().makePhoto = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 1000));
                              _capturedImageBytes = await _captureImage();
                              if (_capturedImageBytes != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CapturePreviewPage(
                                      imageBytes: _capturedImageBytes!,
                                      username: widget.username,
                                    ),
                                  ),
                                );
                              }
                            },
                            text: 'Take Photo',
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> _captureImage() async {
    if (!_isCameraInitialized || _cameraController == null) {
      return null;
    }

    try {
      final XFile file = await _cameraController!.takePicture();
      return await file.readAsBytes();
    } catch (e) {
      print('Error capturing image: $e');
      return null;
    }
  }
}
