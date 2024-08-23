

import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_detail.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_widget_model.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/utils/const_api.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LabourContractAmendmentRequeWidget extends StatefulWidget {
  final String token;
  const LabourContractAmendmentRequeWidget({super.key, required this.token});

  @override
  _LabourContractAmendmentRequeWidgetState createState() =>
      _LabourContractAmendmentRequeWidgetState();
}

class _LabourContractAmendmentRequeWidgetState
    extends State<LabourContractAmendmentRequeWidget> {
   late LabourContractAmendmentRequeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> _labourContracts = [];



final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabourContractAmendmentRequeModel());
    _model.textController1 ??= TextEditingController(text: '');
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textController2 ??= TextEditingController(text: '');
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textController3 ??= TextEditingController(text: '');
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textController4 ??= TextEditingController(text: '');
    _model.textFieldFocusNode4 ??= FocusNode();
    _model.empId = '';
    _model.username = '';
    _model.email = ''; // Initialize empId here
    _model.department = '';
    fetchUserDetails();
  }



  final _amendementRequest=['Name Change','Position Change','Position and Salary Change','Salary Change'];

  String? _selectedAmendementRequest;

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


  
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  Future<void> fetchUserDetails() async {
    final token = await getAuthToken();
    final String? jwt3 = token;
    const String apiUrl = '$apiBaseUrl/hr/api/user_details';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt3',
      },
    );

    if (response.statusCode == 200) {
      
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _model.empId = data['emp_id']; // Employee ID
        _model.username =
            '${data['first_name']} ${data['last_name']}'; // Username
        _model.email = data['email']; // Email
        _model.department = data['department']; // Department
      });
    } else {
      // Handle error
      print('Failed to fetch user details: ${response.statusCode}');
    }
  }



 Future<void> _sendAdminNotification(String email) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/hr/api/send_admin_notification'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'subject': 'Labour Contract Application request',
        'message': 'Labour Contract request by Employee with email $email.',
        'recipients': ['farhanabadubhai@gmail.com'],
      }),
    );

    if (response.statusCode == 200) {
      print('Admin notification sent successfully');
    } else {
      print('Failed to send admin notification: ${response.body}');
    }
  }
  
Future<void> saveLabourContract() async {
  // Validate the form fields before proceeding
  final token = await getAuthToken();
  if (_formKey.currentState!.validate()) {
    final String? jwt3 = token;
    const String apiUrl = '$apiBaseUrl/hr/api/labour-contract';

    final data = {
      'emp_id': _model.empId,
      'username': _model.username,
      'department': _model.department,
      'email': _model.email,
      'group': _model.textController1.text,
      'labourcontract_reason': _selectedAmendementRequest,
      'labourContract_comments': _model.textController3.text,
      'amendment_date':_model.textController2.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt3',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Labour contract created with ID: ${responseData['id']}');

        await _sendAdminNotification(_model.email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Labour Contract sent successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
        print('Leave request successful');
        // Clear input fields
        _model.textController1?.clear();
        _model.textController2?.clear();
        _model.textController3?.clear();
        _model.textController4?.clear();

        // Refresh page - you might need to call a function here that updates the UI state
        setState(() {
          // _selectedAmendementRequest='';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Labour Contract sent successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      } else {
         print('Failed to submit leave request: ${response.body}');
        print('Failed to create labour contract: ${response.statusCode}');
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit Labour Contract request. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {

      print('Error creating labour contract: $e');
    }
  } else {
    // Display a message if form validation fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill all required fields correctly.'),
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
                                      MaterialPageRoute(builder: (context) => EmployepageWidget(token: widget.token)),
                                    );
                                  }
                                },
          ),
          title: Text(
            'Labour Contract ',
            textAlign: TextAlign.start,
           style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 0,
                ),
          ),
          actions: [
            IconButton(
                   onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LabourHistoryBalanceCopyWidget()),
                    );
                   },
                      
                  icon: const Icon(Icons.more_vert),
                
                ),
          ],
          centerTitle: false,
          elevation: 2,
        ),

        body: SafeArea(
          top: true,
          child: Padding(
             padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                        child: Text(
                          'Labour Contract Application',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                        const SizedBox(height: 5.0,),
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
                          'Employee Id',
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
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.idBadge,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 18,
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
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
                          'Business Group ',
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
                                    hintText: 'Business Group',
                                    hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
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
                                      Icons.business_rounded,
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
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Department ',
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
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.briefcase,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 18,
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
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
                    
                    //amenment
                
                    Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 12, 0.0),
                    child: Text(
                      'Reason For Amendment',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedAmendementRequest,
                                items: _amendementRequest.map(
                                  (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins'),), value: e),
                                ).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedAmendementRequest = newValue;
                                  });
                                },
                      decoration: InputDecoration(
                        hintText: 'Reason For Amendment',
                        hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
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
                                      Icons.article_rounded,
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
                     
                    ),
                  ),
                
                
                    
                      
                    
                    
                    
                    
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Expected Date of Amendment ',
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
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          hintText: 'yyyy-mm-dd',
                          hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
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
                            Icons.date_range,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Expected Date of Amendment is required';
                                }
                                return null;
                              },
                        textAlign: TextAlign.start,
                        
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Comment',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(1, -1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                        child: TextFormField(
                          controller: _model.textController3,
                          focusNode: _model.textFieldFocusNode3,
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
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
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
                              Icons.comment_rounded,
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
                            validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Comment is required';
                                }
                                return null;
                              },
                          textAlign: TextAlign.start,
                        
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Center(
                      child: FFButtonWidget(
                              onPressed: saveLabourContract,
                              text: 'Apply',
                              options: FFButtonOptions(
                                height: 40,
                                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color:const Color(0xFF002147),
                                textStyle:
                                    FlutterFlowTheme.of(context).titleSmall.override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          letterSpacing: 0,
                                          
                                        ),
                                elevation: 3,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ), 
                              loadingIndicatorColor: Colors.white,
                            ),
                    ),
                  ],
                  
                ),
              ),
              
            ),
          ),
        ),
      ),
    );
  }
}