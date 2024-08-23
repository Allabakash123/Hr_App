import 'package:team_c/index.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register_model.dart';
export 'register_model.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({
    super.key,
    required this.bs64Image,
  });

  final FFUploadedFile? bs64Image;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  late RegisterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegisterModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'SIGN UP',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Raleway',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context).labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
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
                              Icons.person_outline_sharp,
                              color: FlutterFlowTheme.of(context).black,
                              size: 20.0,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: RichText(
                          textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account?',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              TextSpan(
                                text: ' Login',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primary,
                                  fontSize: 13.0,
                                ),
                                mouseCursor: SystemMouseCursors.click,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>const LoginWidget()),
                                    );
                                  },
                              )
                            ],
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
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
    );
  }
}

