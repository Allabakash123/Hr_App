


import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:team_c/backend/api_requests/api_calls.dart';
import 'package:team_c/pages/attendance_page/bottomnav.dart';
import 'package:team_c/pages/attendance_page/timing_page.dart';
import 'package:team_c/utils/const_api.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'attendance_page_model.dart';
export 'attendance_page_model.dart';
import 'package:http/http.dart' as http;

class AttendancePageWidget extends StatefulWidget {
  final String token;

  const AttendancePageWidget({Key? key, required this.token}) : super(key: key);

  @override
  _AttendancePageWidgetState createState() => _AttendancePageWidgetState();
}

class _AttendancePageWidgetState extends State<AttendancePageWidget> {
  late AttendancePageModel _model;
  String? _userImageBase64;
  String? _username;
  bool _isLoading = false;

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // void initState() {
  //   super.initState();
  //   _model = AttendancePageModel();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => _fetchUserImage());
  //   _initCamera();
  //   FFAppState().loadUserData(_currentUser);
  //   FFAppState().loadState().then((_) {
  //     FFAppState().initializeDailyReset();
  //   });
  // }

  @override
void initState() {
  super.initState();
  _model = AttendancePageModel();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _fetchUserImage();
    FFAppState().loadUserData(widget.token); // Assuming loadUserData can use the token
  });
  _initCamera();
}
  Future<void> _fetchUserImage() async {
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/hr/api/user_details'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        final userImageBase64 = userData['user_image'];
        final username = userData['username'];
        setState(() {
          _userImageBase64 = userImageBase64;
          _username = username;
        });
      } else {
        print('Failed to fetch user image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user image: $e');
    }
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      // No cameras available, handle this case
      return;
    }

    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _model.dispose();
    super.dispose();
  }

  Future<void> _handleCheckIn() async {
    try {
      final image = await _controller.takePicture();
      final capturedImageBase64 = base64Encode(await image.readAsBytes());

      final response = await CheckinCall.call(
        jwt: widget.token,
        imageData: capturedImageBase64,
      );

      if (response.statusCode == 200) {
        final checkInTime =
            getJsonField(response.jsonBody, r'$.check_in_time').toString();
        FFAppState().update(() {
          FFAppState().isCheckIn = true;
          FFAppState().checkIn = checkInTime;
          FFAppState().chekout = '';
          FFAppState().workingHours = '';
        });
        await FFAppState().saveState();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(response.jsonBody['message']),
              backgroundColor: Colors.green),
        );
      } else {
        Navigator.of(context).pop();
        String errorMessage = 'Check-in failed';
        if (response.jsonBody != null && response.jsonBody['error'] != null) {
          errorMessage = response.jsonBody['error'];
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('An unexpected error occurred. Please try again later.'),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _handleCheckOut() async {
    try {
      final image = await _controller.takePicture();
      final capturedImageBase64 = base64Encode(await image.readAsBytes());

      final response = await CheckoutCall.call(
        jwt2: widget.token,
        imageData: capturedImageBase64,
      );

      if (response.statusCode == 200) {
        final checkOutTime =
            getJsonField(response.jsonBody, r'$.checkout_time').toString();
        final workingHours =
            getJsonField(response.jsonBody, r'$.working_hours').toString();
        FFAppState().update(() {
          FFAppState().isCheckIn = false;
          FFAppState().chekout = checkOutTime;
          FFAppState().workingHours = workingHours;
        });
        await FFAppState().saveState();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(response.jsonBody['message'] ?? 'Check-out successful'),
              backgroundColor: Colors.green),
        );
      } else {
        Navigator.of(context).pop();
        String errorMessage = 'Check-out failed';
        if (response.jsonBody != null && response.jsonBody['error'] != null) {
          errorMessage = response.jsonBody['error'];
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('An unexpected error occurred. Please try again later.'),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).secondaryBackground,
                FlutterFlowTheme.of(context).secondaryBackground
              ],
              stops: const [0.0, 1.0],
              begin: const AlignmentDirectional(0.0, -1.0),
              end: const AlignmentDirectional(0, 1.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 15.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Hey ',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    TextSpan(
                                      text: _username ?? 'Loading...',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Please mark your Attendance',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 45.0,
                          height: 45.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _userImageBase64 == null ? Colors.grey : null,
                          ),
                          child: _userImageBase64 == null
                              ? const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.black,
                                )
                              : ClipOval(
                                  child: Image.memory(
                                    base64Decode(_userImageBase64!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 0.0, 20.0),
                        child: TimeDisplayWidget(),
                      ),
                      Text(
                        dateTimeFormat('MMMMEEEEd', getCurrentTimestamp),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).marianBlue,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 50.0, 0.0, 0.0),
                        child: Container(
                          width: 297.0,
                          height: 199.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Stack(
                                  alignment:
                                      const AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    Container(
                                      width: 180.0,
                                      height: 180.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 5.0,
                                            color: Color(0x33000000),
                                            offset: Offset(0.0, 3.0),
                                            spreadRadius: 5.0,
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(
                                          0.0, -0.72),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (!FFAppState().isCheckIn) {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                bool _isLoading = false;
                                                return StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      StateSetter setState) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          12.0),
                                                              child:
                                                                  CameraCheckin(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 45,
                                                            width: 120,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .black),
                                                              ),
                                                              onPressed:
                                                                  _isLoading
                                                                      ? null
                                                                      : () {
                                                                          setState(() =>
                                                                              _isLoading = true);
                                                                          _handleCheckIn()
                                                                              .then((_) {
                                                                            setState(() =>
                                                                                _isLoading = false);
                                                                          });
                                                                        },
                                                              child: _isLoading
                                                                  ? const CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white)
                                                                  : const Text(
                                                                      'Check-in'),
                                                            ),
                                                          ),
                                                          SizedBox(height: 20),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          } else {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                bool _isLoading = false;
                                                return StatefulBuilder(
                                                  builder: (BuildContext
                                                          context,
                                                      StateSetter setState) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          12.0),
                                                              child:
                                                                  CameraCheckin(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 45,
                                                            width: 120,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                            Color>(
                                                                        Colors
                                                                            .black),
                                                              ),
                                                              onPressed:
                                                                  _isLoading
                                                                      ? null
                                                                      : () {
                                                                          setState(() =>
                                                                              _isLoading = true);
                                                                          _handleCheckOut()
                                                                              .then((_) {
                                                                            setState(() =>
                                                                                _isLoading = false);
                                                                          });
                                                                        },
                                                              child: _isLoading
                                                                  ? const CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white)
                                                                  : const Text(
                                                                      'Check-out'),
                                                            ),
                                                          ),
                                                          SizedBox(height: 20),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          }
                                        },
                                        text: '',
                                        options: FFButtonOptions(
                                          width: 140.0,
                                          height: 140.0,
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                  ),
                                          elevation: 15.0,
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(70.0),
                                            bottomRight: Radius.circular(70.0),
                                            topLeft: Radius.circular(70.0),
                                            topRight: Radius.circular(70.0),
                                          ),
                                        ), 
                                        loadingIndicatorColor: Colors.white,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0.0, 0.0, 0.0, 20.0),
                                            child: Icon(
                                              Icons.touch_app,
                                              color: FFAppState().isCheckIn
                                                  ? FlutterFlowTheme.of(context)
                                                      .fireEngineRed
                                                  : FlutterFlowTheme.of(context)
                                                      .persianGreen,
                                              size: 45.0,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const AlignmentDirectional(
                                              0.0, 0.0),
                                          child: Text(
                                            FFAppState().isCheckIn
                                                ? 'Checkout'
                                                : 'Checkin',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12.0,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 20.0, 0.0, 140.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Color(0xFFDA9025),
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: Text(
                                  'Check In',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .orangePantone,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ),
                              Text(
                                FFAppState().checkIn,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .chocolateCosmos,
                                      fontSize: 16.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: Icon(
                                  Icons.outbond_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .fireEngineRed,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 12.0),
                                child: Text(
                                  'Check Out',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .orangePantone,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  FFAppState().chekout,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .chocolateCosmos,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 10.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.hourglassEnd,
                                  color:
                                      FlutterFlowTheme.of(context).pacificCyan,
                                  size: 20.0,
                                ),
                              ),
                              Text(
                                'Total Hours',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .orangePantone,
                                      fontSize: 16.0,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5.0, 12.0, 0.0, 12.0),
                                child: Text(
                                  FFAppState().workingHours,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .chocolateCosmos,
                                        fontSize: 16.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      ),
    );
  }
}

class CameraCheckin extends StatefulWidget {
  const CameraCheckin({Key? key}) : super(key: key);

  @override
  _CameraCheckinState createState() => _CameraCheckinState();
}

class _CameraCheckinState extends State<CameraCheckin> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _selectedCameraIndex = _cameras.indexWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
      if (_selectedCameraIndex == -1) {
        _selectedCameraIndex =
            0; // Fallback to the first camera if no front camera is found
      }
      _initializeCamera(_cameras[_selectedCameraIndex]);
    } else {
      // No cameras available, handle this case
      setState(() {});
    }
  }

  void _initializeCamera(CameraDescription cameraDescription) {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller?.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  void _flipCamera() {
    if (_cameras.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _initializeCamera(_cameras[_selectedCameraIndex]);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity, // Background color
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller != null && _initializeControllerFuture != null)
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_controller?.value.isInitialized ?? false) {
                    return Center(
                      child: Container(
                        margin: EdgeInsets.all(
                            20), // Add margin around the camera preview
                        width: MediaQuery.of(context).size.width *
                            0.9, // 90% of screen width
                      //  height: MediaQuery.of(context).size.height * 0.5, // 80% of screen height
                      height: 500,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(0), // Rounded corners
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _controller!.value.previewSize!.height,
                              height: _controller!.value.previewSize!.width,
                              child: CameraPreview(_controller!),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'Error: Camera initialization failed',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          Positioned(
            top: 40,
            right: 40,
            child: IconButton(
              icon: const Icon(Icons.flip_camera_ios),
              color: Colors.white,
              onPressed: _flipCamera,
            ),
          ),
        ],
      ),
    );
  }
}