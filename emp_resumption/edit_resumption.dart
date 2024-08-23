// ignore_for_file: unnecessary_import, use_super_parameters, library_private_types_in_public_api, unused_field, avoid_print, unused_element, use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations, sort_child_properties_last, body_might_complete_normally_nullable

import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/emp_resumption/empresumption_model.dart';
import 'package:team_c/emp_resumption/empresumption_widget.dart';
import 'package:team_c/emp_resumption/history_resumption_widget.dart';
import 'package:team_c/employee_exception/employee_exception_model.dart';
import 'package:team_c/employee_exception/employee_exception_widget.dart';
import 'package:team_c/employee_exception/exception_history.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/utils/const_api.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class EmployeeEditWidget extends StatefulWidget {
  final Map<String, dynamic> exceptionRecord;
  const EmployeeEditWidget({
    Key? key,
    required this.exceptionRecord,
  }) : super(key: key);


  @override
  _EmployeeExceptiontWidgetState createState() =>
      _EmployeeExceptiontWidgetState();
}

class _EmployeeExceptiontWidgetState
    extends State<EmployeeEditWidget> {
   late EmployeeResumptionModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
_EmployeeExceptiontWidgetState(){
  _selectReasonChoice=_ResumptionList[0];
}
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmployeeResumptionModel());



    _model.textController1??= TextEditingController(text: widget.exceptionRecord['group']);
    _model.textFieldFocusNode1 ??= FocusNode();

    _selectReasonChoice=widget.exceptionRecord['resumption_status'];

    _model.textController2 ??= TextEditingController(text: widget.exceptionRecord['enter_date']);
    _model.textFieldFocusNode2 ??= FocusNode();

    // _model.textController3 ??= TextEditingController(text: widget.exceptionRecord['resumption_status']);
    // _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController(text: widget.exceptionRecord['other']);
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController(text: widget.exceptionRecord['days_overstayed'].toString());
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController(text: widget.exceptionRecord['resumption_comment']);
    _model.textFieldFocusNode6 ??= FocusNode();

    

    
    
    _model.empId =  widget.exceptionRecord['emp_id'];
    _model.username =  widget.exceptionRecord['username'];
    _model.email =  widget.exceptionRecord['email']; // Initialize empId here
    _model.department = widget.exceptionRecord['department'];


    print('Business Group: ${_model.textController1.text}');
    print('Reason Category: $_ResumptionList');
    // print('Date of Exception: ${_model.textController2.text}');
        
  }

  
  final _ResumptionList = [
   'Overstayed with prior intimation and separate leave application for extension of overstayed leave period is to be submitted',
    'Overstayed without prior approval or intimation and is liable for termination',
    'Overstayed without prior approval/intimation',
    'Reported for duty prior to expiry of leave',
    'Reported for duty without any overstay',];
 

   String? _selectReasonChoice;


  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


Future<void> editEmployeeResumption(int resumptionId, Map<String, dynamic> resumptionData, String jwtToken) async  {
   final token = await getAuthToken();
  
  
  final String? jwt3 = token;
  final url = Uri.parse('$apiBaseUrl/hr/api/employee_resumption-update/$resumptionId');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt3',
  };

  final body = jsonEncode(resumptionData);

  try {
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Employee Resumption updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to HistoryBalanceCopyWidget
      Navigator.of(context).pushReplacementNamed('EmployeeResumption');
    } else {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update Employee Resumption.'),
          backgroundColor: Colors.red,
        ),
      );
      // Do not navigate to HistoryBalanceCopyWidget on error
    }
  } catch (e) {
    // Show error snackbar
    // Do not navigate to HistoryBalanceCopyWidget on error
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
          backgroundColor: const Color(0xFF002125),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 40,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
             Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EmployeeResumption()),
              );
            },
          ),
          title: Text(
            'Employee Resumption Data Update',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 14,
              letterSpacing: 0,
            ),
          ),
          // actions: [
          //   IconButton(
          //          onPressed: (){
          //             Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => const EmployeeExceptionHistory()),
          //           );
          //          },
                      
          //         icon: const Icon(Icons.more_vert),
                
          //       ),
          // ],
          centerTitle: false,
          elevation: 2,
        ),

         body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Resumption Report-Application',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.of(context).black,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Employee Name',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 0, 0, 0),
                            child: Icon(
                              Icons.person,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 0, 0),
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Employee Id',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.idBadge,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(
                                  '${_model.empId}',
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
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Email Address ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 0, 0, 0),
                            child: Icon(
                              Icons.email_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 0, 0, 0),
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
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Department ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: FaIcon(
                                FontAwesomeIcons.briefcase,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(
                                  '${_model.department}',
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
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Business Group ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Business Group',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Readex Pro',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.business_sharp,
                          size: 18,
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                          return 'Business Group is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Enter Date ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Readex Pro',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.business_sharp,
                          size: 18,
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                          return 'Enter date is Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 5.0, 12, 0.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '*',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context)
                                        .fireEngineRed,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                             TextSpan(
                              text: 'Resumption Status',
                             style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                            )
                          ],
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0,
                                  ),
                        ),
                      )),
                   Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
  child: DropdownButtonFormField<String>(
    value: _selectReasonChoice,
    items: _ResumptionList
        .map(
          (e) => DropdownMenuItem(
            child: Text(
              e,
              overflow: TextOverflow.ellipsis, // Allow text to wrap
            ),
            value: e,
          ),
        )
        .toList(),
    onChanged: (newValue) {
      setState(() {
        _selectReasonChoice = newValue;
        // You can add additional logic here if needed
      });
    },
    decoration: InputDecoration(
      hintText: 'Select Resumption Type',
      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
        fontFamily: 'Readex Pro',
        color: FlutterFlowTheme.of(context).primaryText,
        letterSpacing: 0.0,
        fontSize: 12,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: FlutterFlowTheme.of(context).error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
      prefixIcon: Icon(
        Icons.document_scanner_sharp,
        color: FlutterFlowTheme.of(context).primaryText,
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
    validator: (value) {
      // Add your validation logic here if needed
    },
    isExpanded: true,
  ),
),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Others ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Others',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0,
                              fontSize: 12.0,
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.business_sharp,
                          size: 18,
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                          return 'Others required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Days Overstayed',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Days Overstayed',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0,
                              fontSize: 12.0
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.business_sharp,
                          size: 18,
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                          return 'Days Overstayed is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Comment',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            letterSpacing: 0,
                            fontSize: 12,
                            color: Colors.black),
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
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Comment',
                        hintStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0,
                              fontSize: 12.0
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.business_sharp,
                          size: 18,
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                          return 'Comment is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  
                const SizedBox(height: 30.0,),
               Center(
                 child: FFButtonWidget(
                      onPressed: () async {
                         final token = await getAuthToken();

                        final exceptionId = widget.exceptionRecord['id']; // Assuming you have access to the contract ID
                        final visaData = {
                            'emp_id': _model.empId,
                            'username': _model.username,
                            'department': _model.department,
                            'email': _model.email,
                            'group': _model.textController1.text,                 
                            'enter_date': _model.textController2.text,
                                                      
                             
                            'other': _model.textController4.text,
                            'resumption_status':_selectReasonChoice,
                            'days_overstayed': (_model.textController5.text).toString(),
                            'resumption_comment': _model.textController6.text
                 
                          
                        };
                        
                        final jwtToken = token; // Assuming this retrieves the JWT token
                 
                        try {
                          await editEmployeeResumption(exceptionId, visaData, jwtToken!);
                          
                          // Navigate to next page if contract is updated successfully
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmployeeResumption(),
                            ),
                          );
                        } catch (e) {
                          print('Error: $e');
                          // Show error pop-up
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update Employee Exception. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      text: 'Update',
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(22, 0, 22, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color:Color(0xFF002125),
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ), 
                      loadingIndicatorColor: Colors.white,
                    ),
               ),

              ],
            ),
          ),
        ),
      ),
    ));
  }
}





