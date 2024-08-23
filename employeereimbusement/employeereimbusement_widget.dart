

import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employeereimbusement/employeereimbusement_model.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/historybalance/historybalance_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmployeeReimbursementWidget extends StatefulWidget {
  final String token;
  const EmployeeReimbursementWidget({Key? key, required this.token}) : super(key: key);

  @override
  _EmployeeReimbursementWidgetState createState() =>
      _EmployeeReimbursementWidgetState();
}

class _EmployeeReimbursementWidgetState
    extends State<EmployeeReimbursementWidget> {
  late EmployeeReimbursementModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _EmployeeReimbursement = [];

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  
  final _requestList = [
  'Air Passage Recruitment',
  'Airticket Reimbursement',
  'Examination Reimbursement',
  'Food Reimbursement',
  'Insurance Claim',
  'Medical Fee Recruitment',
  'Parking Fees',
  'Petrol Charges',
  'Postal Charges',
  'Salik Fee',
  'School Fees',
  'Telephone Bill Claim',
  'Transportation Fee',
  'Vehicle Repair Charges',
  'Vehicle related reimbursement'
];
final _noteType=['Supporting bills should be scanned and attached in request form, originals should be submitted in HRD.Any claims without receipts will not be paid.'];
 bool _isLoading = false;
  String? _selectedRequesrList;
   String? _selectedNote;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmployeeReimbursementModel());
    _model.textController1 ??= TextEditingController(text: '');
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textController2 ??= TextEditingController(text: '');
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textController3 ??= TextEditingController(text: '');
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textController4 ??= TextEditingController(text: '');
    _model.textFieldFocusNode4 ??= FocusNode();
    _model.textController5 ??= TextEditingController(text: '');
    _model.textFieldFocusNode5 ??= FocusNode();
    _model.empId = '';
    _model.username = '';
    _model.email = ''; // Initialize empId here
    _model.department = '';
    _fetchUserDetails();
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


  Future<void> _fetchUserDetails() async {
    setState(() {
      _isLoading = true;
    });
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/hr/api/user_details'),
        headers: {
          'Authorization': 'Bearer $jwt3',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _employeeNameController.text = '${data['first_name']} ${data['last_name']}'?? '';
          _employeeIdController.text = data['emp_id'] ?? '';
          _emailController.text = data['email'] ?? '';
          _departmentController.text = data['department'] ?? '';
        });
      } else {
        // Handle error response
        print('Failed to fetch user details: ${response.body}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error fetching user details: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }



 Future<void> _sendAdminNotification(String email) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/hr/api/send_admin_notification'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'subject': 'Employee  Reimbursement Application request',
        'message': 'Employee Reimbursement request by Employee with email $email.',
        'recipients': ['farhanabadubhai@gmail.com'],
      }),
    );

    if (response.statusCode == 200) {
      print('Admin notification sent successfully');
    } else {
      print('Failed to send admin notification: ${response.body}');
    }
  }




Future<void> sendEmployeeReimbursement() async {
  // Validate the form fields before proceeding
  if (_formkey.currentState!.validate()) {
    
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;
    const String apiUrl = '$apiBaseUrl/hr/api/employee-reimbursement';

    final data = {
      "username": _employeeNameController.text,
        "emp_id": _employeeIdController.text,
        "email": _emailController.text,
        "department": _departmentController.text,
      'group': _model.textController1.text,
     
      'reimbursement_type': _selectedRequesrList,
      'enter_amount': _model.textController3.text,
      'employeereimbursement_comment': _model.textController4.text,
      'note': _model.textController5.text, // Add a new text controller for 'note'
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
        // Show success popup message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Employee reimbursement request submitted successfully'),
          ),
        );

        // Clear text fields after successful submission
        setState(() {
          _model.textController1?.clear();
          _model.textController2?.clear();
          _model.textController3?.clear();
          _model.textController4?.clear();
          _model.textController5?.clear();
          _selectedRequesrList = null; // Clear selected request type
        });
      } else {
         print('Failed to submit leave request: ${response.body}');
        // Show error popup message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to submit employee reimbursement request'),
          ),
        );
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
      // Handle exception cases
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } else {
    // Display a message if form validation fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
            'Employee Reimbursement Request',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 0,
            ),
          ),
          actions: [
            IconButton(
                   onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EmployeeHistoryBalanceCopyWidget()),
                    );
                   },
                      
                  icon: const Icon(Icons.more_vert),
                  tooltip: 'History',
                
                ),
          ],
          centerTitle: false,
          elevation: 2,
        ),

        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                        child: Text(
                          'Employee Reimbursement Report-Application',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 14,
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
                                  _employeeNameController.text,
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
                                    _employeeIdController.text,
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
                                Icons.email_outlined,
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
                                 _emailController.text,
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
                                     _departmentController.text,
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
                
                
                
                      Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 12, 0.0),
                    child:RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Poppins',
                                              color: FlutterFlowTheme.of(context).fireEngineRed,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                       TextSpan(
                                        text: 'Reimbursement Type',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Poppins',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                )
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedRequesrList,
                                items: _requestList.map(
                                  (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins'),), value: e),
                                ).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedRequesrList = newValue;
                                  });
                                },
                      decoration: InputDecoration(
                        hintText: 'Reimbursement Type',
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
                        child: RichText(
                                  textScaler: MediaQuery.of(context).textScaler,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '*',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Poppins',
                                              color: FlutterFlowTheme.of(context).fireEngineRed,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                       TextSpan(
                                        text: 'Enter Amount(AED)',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Poppins',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                )
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
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          hintText: 'Enter amount',
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
                          prefixIcon:Icon(
                            Icons.money,
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
                                    return 'Enter amount is required';
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
                    
                
                
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Note',
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
                                    hintText: 'Note',
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
                                   validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Note is required';
                                  }
                                  return null;
                                },
                                  textAlign: TextAlign.start,
                                  
                                ),
                              ),
                
                
                    
                    
                    
                    
                    
                    
                    
                    Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              FFButtonWidget(
                                onPressed: sendEmployeeReimbursement,
                                text: 'Apply',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).oxfordBlue,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
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
      ),
   );
  }
}