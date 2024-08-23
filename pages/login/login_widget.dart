
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:team_c/ForgotPassword/account_recovery.dart';
import 'package:team_c/camera/camera_widget.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/pages/login/face_login.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';
import 'package:team_c/utils/helpers/helper_function.dart';
import 'package:team_c/utils/image_strings.dart';
import 'package:team_c/utils/spacing_stle.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginModel _model;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initSharedPref();
    _model = createModel(context, () => LoginModel());
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _model.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(String username, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        var uri = Uri.parse('http://192.168.57.90:8000/hr/api/login');
        var body = jsonEncode({
          'username': username,
          'password': password
        });

        http.Response response = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());
          final String token = data['token'];
          
          print('Token received: $token');
          
          await prefs.setString('token', token);

          // Clear previous user's data
          

          // Fetch and set new user's data
          await FFAppState().loadUserData(username);

           ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EmployepageWidget(token: token)),
          );
        } else {
          var error = jsonDecode(response.body.toString())['error'];
          String errorMessage;
          
          switch (response.statusCode) {
            case 404:
              errorMessage = 'User not found';
              break;
            case 401:
              errorMessage = error == 'Invalid password' ? 'Invalid password' : 'Account not activated';
              break;
            default:
              errorMessage = 'An error occurred. Please try again later.';
          }
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage,
                style: GoogleFonts.getFont(
                  'Roboto',
                  color: Colors.white, 
                  fontSize: 16.0,
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        print(e.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'An error occurred. Please try again later.',
              style: GoogleFonts.getFont(
                'Roboto',
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all required fields correctly.',
            style: GoogleFonts.getFont(
              'Roboto',
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              child:ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
                child: Center(
                  child: Padding(
                     padding: TSpacingStyle.paddingWithAppBarHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const login_header(),
                        
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding:const EdgeInsets.symmetric(
                                vertical: TSizes.spaceBtwSections),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextFormField(
                                  controller: usernameController,
                                  focusNode: _model.textFieldFocusNode1,
                                  autofocus: true,
                                  textCapitalization: TextCapitalization.none,
                                  textInputAction: TextInputAction.next,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Username/EmpId',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context).black,
                                          fontSize: 15.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context).black,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person_outline_sharp,
                                      color: Color(0xFF050505),
                                      size: 20.0,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 16.0,
                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                ),
                               
                               const SizedBox(height: TSizes.spaceBtwInputFields),
                                TextFormField(
                                  controller: passwordController,
                                  focusNode: _model.textFieldFocusNode2,
                                  autofocus: true,
                                  obscureText: !_model.passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context).black,
                                          fontSize: 15.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                          fontFamily: 'Readex Pro',
                                          color: const Color(0xFF050505),
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock_open,
                                      color: Color(0xFF050505),
                                      size: 20.0,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => _model.passwordVisibility = !_model.passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: FlutterFlowTheme.of(context).black,
                                        size: 15.0,
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 16.0,
                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                                 const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                    
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () =>Get.to(()=>const AccountRecoveryWidget()),
                                      
                                      child: Text(
                                        'Forgot Password',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: TSizes.spaceBtwSections),
                                ElevatedButton(
                                  onPressed: () {
                                    login(usernameController.text.toString(),
                                        passwordController.text.toString());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                    backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
                                    padding: const EdgeInsets.symmetric(horizontal:TSizes.buttonWidth, vertical: TSizes.buttonHeight),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    elevation: 3.0,
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          fontSize: TSizes.fontSizeMd*1.2,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                                 const SizedBox(height: TSizes.defaultSpace),
                                 
                                 RichText(
                                   textScaler: MediaQuery.of(context).textScaler,
                                   text: TextSpan(
                                     children: [
                                       TextSpan(
                                         text: 'Don\'t have an Account?',
                                         style: FlutterFlowTheme.of(context)
                                             .bodyMedium
                                             .override(
                                               fontFamily: 'Readex Pro',
                                               color: FlutterFlowTheme.of(context)
                                                   .primaryText,
                                               fontSize:TSizes.fontSizeSm,
                                               fontWeight: FontWeight.w600,
                                             ),
                                       ),
                                       TextSpan(
                                         text: ' Register here',
                                         style: GoogleFonts.getFont(
                                           'Poppins',
                                           color: FlutterFlowTheme.of(context).primary,
                                           fontWeight: FontWeight.w500,
                                           fontSize: TSizes.fontSizeMd,
                                         ),
                                         mouseCursor: SystemMouseCursors.click,
                                         recognizer: TapGestureRecognizer()
                                           ..onTap = () async {
                                               Navigator.push(
                                                 context,
                                                 MaterialPageRoute(
                                                   builder: (context) => const CameraWidget(),
                                                 ),
                                               );
                                             },
                                       )
                                       
                                     ],
                                     style: FlutterFlowTheme.of(context).bodyMedium,
                                   ),
                                 ),
                                const SizedBox(height: 20),
                                const Divider(
                                  height: 10,
                                  color: Colors.black,
                                  thickness: 1,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                const Text(
                                  "Or",
                                  style: TextStyle(fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigate to the FaceLogin page when the text is clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const FaceLogin()),
                                      );
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: const Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Login with face Recognition",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold)),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            ImageIcon(
                                              AssetImage(HImages.face),
                                              size: 30, // Adjust the size as needed
                                              color:
                                                  Colors.black, // Adjust the color as needed
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

class login_header extends StatelessWidget {
  const login_header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SIGN IN',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Raleway',
                color: FlutterFlowTheme.of(context).oxfordBlue,
                fontSize: TSizes.fontSizeMd*2.0,
                fontWeight: FontWeight.bold,
              ),
              
        ),
      ],
    );
    
  }
}