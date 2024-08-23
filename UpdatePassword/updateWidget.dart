import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/UpdatePassword/updatepasswordModel.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/components/sucessbox.dart';
import 'package:team_c/index.dart';
import 'package:team_c/utils/const_api.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class UpdatePasswordWidget extends StatefulWidget {
  const UpdatePasswordWidget({super.key});

  @override
  State<UpdatePasswordWidget> createState() => _UpdatePasswordWidgetState();
}

class _UpdatePasswordWidgetState extends State<UpdatePasswordWidget> {
  late UpdatePasswordModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdatePasswordModel());

    _model.textController1 ??= TextEditingController(text: '');
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(text: '');
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController(text: '');
    _model.textFieldFocusNode3 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

      const String apiUrl = '$apiBaseUrl/hr/api/update-password';

      final data = {
        'old_password': _model.textController1.text,
        'new_password': _model.textController2.text,
      };

      try {
        final response = await http.put(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $jwt3',
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          await showDialog(
            context: context,
            builder: (dialogContext) {
              return Dialog(
                elevation: 0,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                alignment: AlignmentDirectional(0, 0)
                    .resolve(Directionality.of(context)),
                child: GestureDetector(
                  onTap: () => _model.unfocusNode.canRequestFocus
                      ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                      : FocusScope.of(context).unfocus(),
                  child: SucessBoxWidget(
                    successBox: () async {},
                  ),
                ),
              );
            },
          ).then((value) => setState(() {}));
        } else {
          final errorMessage = json.decode(response.body)['error'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
            ),
          );
        }
      } catch (e) {
        print('Error creating Visiting Card: $e');
      }
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 20,
            ),
             onPressed: () async {
                                  final token = await getAuthToken();
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfilePageWidget(token: token)),
                                    );
                                  }
                                },
          ),
          title: Text(
            'Change Password',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                        child: Text(
                          'Current Password',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 10),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController1,
                            focusNode: _model.textFieldFocusNode1,
                            autofocus: true,
                            obscureText: !_model.passwordVisibility1,
                            decoration: InputDecoration(
                              labelText: 'Current Password',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 13,
                                    letterSpacing: 0,
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
                           prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Color(0xFF050505),
                            size: 20,
                          ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.passwordVisibility1 =
                                      !_model.passwordVisibility1,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.passwordVisibility1
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 19,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Current Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                        child: Text(
                          'New Password',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 10),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController2,
                            focusNode: _model.textFieldFocusNode2,
                            autofocus: true,
                            obscureText: !_model.passwordVisibility2,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 13,
                                    letterSpacing: 0,
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
                           prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Color(0xFF050505),
                            size: 20,
                          ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.passwordVisibility2 =
                                      !_model.passwordVisibility2,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.passwordVisibility2
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 19,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'New Password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 5),
                        child: Text(
                          'Confirm Password ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _model.textController3,
                            focusNode: _model.textFieldFocusNode3,
                            autofocus: true,
                            obscureText: !_model.passwordVisibility3,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                  ),
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 13,
                                    letterSpacing: 0,
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
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: Color(0xFF050505),
                            size: 20,
                          ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _model.passwordVisibility3 =
                                      !_model.passwordVisibility3,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _model.passwordVisibility3
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 19,
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm Password is required';
                              }
                              if (value != _model.textController2!.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Builder(
                          builder: (context) => Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
                            child: FFButtonWidget(
                              onPressed: _updatePassword,
                              text: 'Change Password',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 55,
                                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).oxfordBlue,
                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      letterSpacing: 0,
                                    ),
                                elevation: 8,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ), 
                              loadingIndicatorColor: Colors.white,
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
        ),
      ),
    );
  }
}
