
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';
import 'package:team_c/visiting_card/visiting_form_model.dart';
import 'package:team_c/visiting_card/visiting_update_models.dart';
import 'package:team_c/visiting_card/visting_card.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class VistingCardFormUpdateWidget extends StatefulWidget {
  final Map<String, dynamic> visitingData;
  const VistingCardFormUpdateWidget({Key? key, required this.visitingData
  }) : super(key: key);
  @override
  _VistingCardFormUpdateWidgetState createState() =>
      _VistingCardFormUpdateWidgetState();
}
class _VistingCardFormUpdateWidgetState
    extends State<VistingCardFormUpdateWidget> {
   late VisitingCardFormUpdateModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VisitingCardFormUpdateModel());
    _model.textController1 ??= TextEditingController(text: widget.visitingData['mobilenum'].toString());
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(text: widget.visitingData['Visitingcountry']);
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController(text: widget.visitingData['poBox']);
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController(text: widget.visitingData['unitedstate']);
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController(text: widget.visitingData['telphone']);
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController(text: widget.visitingData['extnum']);
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController(text: widget.visitingData['faxnum']);
    _model.textFieldFocusNode7 ??= FocusNode();


    _model.username = widget.visitingData['username'];
    _model.email = widget.visitingData['email']; // Initialize empId here
    _model.designation = widget.visitingData['designation'];
    // _model.mobilenum = widget.visitingData['mobilenum'].toString();
    // _model.country = widget.visitingData['country'];
  }
  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
Future<void> editVisiting(int visitingId, Map<String, dynamic> visitingData, String jwtToken) async  {
  
Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

  final url = Uri.parse('$apiBaseUrl/hr/api/visiting-card-update/$visitingId');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt3',
  };
  final body = jsonEncode(visitingData);
  try {
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Visiting card updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pushReplacementNamed('ProfilePageWidget');
    } else {
         print('Failed to submit leave request: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update Visiting card.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
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
          backgroundColor: const Color(0xFF002147),
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
           final token = await getAuthToken();
                  if (token != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployepageWidget(token: token)),
                    );
                  }
                                },
          ),
          title: Text(
            'Visitng Card ',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 0,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),

        body: SafeArea(
          top: true,
          child: Padding(
             padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: 5.0,),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Employee Name',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Icon(
                              Icons.person,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                '${_model.username}',
                                textAlign: TextAlign.start,
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                 
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Email Address ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Icon(
                              Icons.email,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                '${_model.email}',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                      Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Designation',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                            child: Icon(
                              Icons.title,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(
                                '${_model.designation}',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Mobile Number',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'P.O Box',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                    fontSize: 12
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  prefixIcon: Icon(
                                    Icons.call,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mobile Number is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                             Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Country',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController2,
                                focusNode: _model.textFieldFocusNode2,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Country',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                    fontSize: 12
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  prefixIcon: Icon(
                                    Icons.location_on,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Country is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                     
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'P.O BOX',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController3,
                                focusNode: _model.textFieldFocusNode3,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'P.O Box',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  prefixIcon: Icon(
                                    Icons.local_post_office_sharp,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'P.O Box is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'United State',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController4,
                                focusNode: _model.textFieldFocusNode4,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'United State',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                prefixIcon: Icon(
                                    Icons.place,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'united state is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Tel Phone',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController5,
                                focusNode: _model.textFieldFocusNode5,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Tel Phone',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                prefixIcon: Icon(
                                    Icons.call,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tel Phone is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Ext Number',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController6,
                                focusNode: _model.textFieldFocusNode6,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Ext Number',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                prefixIcon: Icon(
                                    Icons.numbers_outlined,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ext Number is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Fax Number',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                              child: TextFormField(
                                controller: _model.textController7,
                                focusNode: _model.textFieldFocusNode7,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Fax Number',
                                  hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryText,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                prefixIcon:Icon(
                                    Icons.numbers,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    size: 18,
                                  ),
                                ),
                                 style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Fax  is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                  const SizedBox(height: 20.0,),
                   Center(
                    child: FFButtonWidget(
                          onPressed: () async {
                            final token = await getAuthToken();

                            final visitingData = widget.visitingData;
                            if (visitingData != null  && visitingData.containsKey('id')) {
                              final visitingId = visitingData['id'];
                              final updatedVisitingData = {
                                'mobilenum': (_model.textController1.text).toString(),
                                'Visitingcountry': _model.textController2.text,
                                'username': _model.username,
                                'email': _model.email,
                                'designation': _model.designation,
                                'poBox': _model.textController3.text,
                                'unitedstate': _model.textController4.text,
                                'telphone': _model.textController5.text,
                                'extnum': _model.textController6.text,
                                'faxnum': _model.textController7.text,
                              };
                              print('Updated Profile Data: $updatedVisitingData');

                              final jwtToken = token;

                              try {
                                await editVisiting(visitingId, updatedVisitingData, jwtToken!);

                                // Navigate to next page if visiting card is updated successfully
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  CardviisitWidget(),
                                  ),
                                );
                              } catch (e) {
                                print('Error: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to update visiting card. Please try again.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              print('visitingData is null or does not contain an "id" key');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to retrieve visiting card ID.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          text: 'Save',
                          options: FFButtonOptions(
                            height: 40,
                            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).oxfordBlue,
                            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              letterSpacing: 0,
                              fontSize: TSizes.fontSizeMd*1.0
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          
                           loadingIndicatorColor: Colors.white,
                        ),

                )],
                
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}