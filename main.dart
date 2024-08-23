

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/app_state.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/auth/custom_auth/custom_auth_user_provider.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/index.dart';
import 'package:team_c/pages/login/face_login.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();
  await authManager.initialize();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token'); // Retrieve token from SharedPreferences
  
  await FlutterFlowTheme.initialize();
  
  runApp(
     ChangeNotifierProvider(
    create: (context) => appState,
    child:  MyApp(token: token)
  )
    
    
    ); // Pass the token to MyApp



}

class MyApp extends StatefulWidget {


  final String? token; // Make token nullable

  const MyApp({Key? key, this.token}) : super(key: key); 
  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  final platform = MethodChannel('com.yourcompany.app/share');
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;
  
  late Stream<TeamCAuthUser> userStream;

  // late AppStateNotifier _appStateNotifier;


  @override
  void initState() {
    super.initState();
    _checkPlatformSetup();

    
    
  }
 Future<void> _checkPlatformSetup() async {
    try {
      final String result = await platform.invokeMethod('checkSetup');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to check setup: '${e.message}'.");
    }
  }



 // Update constructor
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'HR',
       theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      home: widget.token != null && widget.token!.isNotEmpty // Check if token is not null and not empty
          ? EmployepageWidget(token: widget.token!) // Use token with null check
          : const LoginWidget(),
    );
  }
}
