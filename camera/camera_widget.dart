
import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:team_c/pages/login/login_widget.dart';
import 'package:team_c/utils/constants/sizes.dart';
import '/components/base64to_file_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'camera_model.dart';
export 'camera_model.dart';

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key});
  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraModel _model;
  CameraController? _cameraController = null;
  late Future<void> _initializeControllerFuture;
  int _selectedCameraIndex = 0;
  List<CameraDescription> _cameras = [];
  late Uint8List? _capturedImageBytes;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CameraModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    _initializeCameras();
  }

  @override
  void dispose() {
    _model.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _selectedCameraIndex = _cameras.indexWhere((camera) => camera.lensDirection == CameraLensDirection.front);
      if (_selectedCameraIndex == -1) {
        _selectedCameraIndex = 0;
      }
      await _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameraController = CameraController(_cameras[_selectedCameraIndex], ResolutionPreset.max);
      _initializeControllerFuture = _cameraController!.initialize();
      await _initializeControllerFuture;
      if (mounted) setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      await _initializeCamera();
    }
  }

  Future<Uint8List?> _captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return null;
    }
    final XFile file = await _cameraController!.takePicture();
    final Uint8List bytes = await file.readAsBytes();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register Account',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: FlutterFlowTheme.of(context).oxfordBlue,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Text(
                            'Capture the face to register',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: FlutterFlowTheme.of(context).oxfordBlue,
                                ),
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
                                  text: 'Please take a photo in a well-lit area, ensuring that the captured face is clear.',
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
                        SizedBox(
                          width: 250.0,
                          height: 250.0,
                          child: Stack(
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: SizedBox(
                                  width: 230.0,
                                  height: 400.0,
                                  child: _cameraController != null && _cameraController!.value.isInitialized
                                    ? CameraPreview(_cameraController!)
                                    : const Center(child: CircularProgressIndicator()),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  icon: const Icon(Icons.flip_camera_android),
                                  onPressed: _flipCamera,
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                         const SizedBox(height: TSizes.spaceBtwSections),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                FFAppState().makePhoto = true;
                              });
                              await Future.delayed(const Duration(milliseconds: 1000));
                              _capturedImageBytes = await _captureImage();
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () => _model.unfocusNode.canRequestFocus
                                        ? FocusScope.of(context)
                                            .requestFocus(_model.unfocusNode)
                                        : FocusScope.of(context).unfocus(),
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: Base64toFileWidget(
                                        base64ImageBytes: _capturedImageBytes,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            text: 'Take Photo',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).oxfordBlue,
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
                            ), loadingIndicatorColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginWidget()),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an Account? ',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Login here',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context).marianBlue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer(),
                                  ),
                                ],
                              ),
                            ),
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
}