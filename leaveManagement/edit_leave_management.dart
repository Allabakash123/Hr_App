


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_model.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/leaveManagement/leave_management_history_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'leave_management_model.dart';

import '/flutter_flow/flutter_flow_util.dart';

class LeaveEditWidget extends StatefulWidget {
  final Map<String, dynamic> leaveRecordId;
  const LeaveEditWidget({
    super.key,
    required this.leaveRecordId,
  });
  @override
  State<LeaveEditWidget> createState() => _LeaveEditWidgetState();
}

class _LeaveEditWidgetState extends State<LeaveEditWidget> {
  late LeaveManagementModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
 

  _LeaveEditWidgetState(){
      _selectedAbsenceType=_absenceType[0];
      _selectedAbsenceCategory=_absenceCategory[0];
      _selectedAbsenceReason=_leaveReasonType[0];
      _selectedRequestAirticket=_requestAirticket[0];

  }

  bool _isLoading = false;
final _absenceType = [
    'Annual Leave',
    'Sick Leave',
    'Maternity Leave',
    'Personal Leave',
    'Unpaid Leave',
  ];
  final _absenceCategory = {
    'Annual Leave': 'Vacation',
    'Sick Leave': 'Sickness',
    'Maternity Leave': 'Maternity',
    'Personal Leave': 'Personal Leave',
    'Unpaid Leave': 'Unpaid Leave',
  };
  final _leaveReasonType = [
    '1 Hour Exam Paper','2 Hour Exam Paper',
    '3 Hour Exam Paper','Accident',
    'Accomodation Shifting','Annual Leave Extension',
    'Annual Vacation','Funeral','Hajj',
    'Hospitalized','Others',
    'Rest / Break','Umrah',
    'Work Stress'
  ];
  final _requestAirticket = [
    'Book Airticket',
    'Not Aplicable',
    'Reimburse Airticket',
  ];
  String ? _selectedAbsenceType;
  String ? _selectedAbsenceCategory;
  String ? _selectedAbsenceReason;
  String ? _selectedRequestAirticket;

  @override
  void initState() {
    super.initState();
    
    _model = createModel(context, () => LeaveManagementModel());
  
    _model.empId =  widget.leaveRecordId['emp_id'];
    _model.username =  widget.leaveRecordId['username'];
    _model.email =  widget.leaveRecordId['email']; // Initialize empId here
    _model.department = widget.leaveRecordId['department'];
    
    _model.textController1 ??= TextEditingController(text: widget.leaveRecordId['group']);
    
    _model.textFieldFocusNode1 ??= FocusNode();

     _model.textController2 ??= TextEditingController(text: widget.leaveRecordId['start_date']);
     
      _model.textController3 ??= TextEditingController(text: widget.leaveRecordId['end_date']);
     
      _model.textController4 ??= TextEditingController(text: widget.leaveRecordId['replaced_by']);
     
      _model.textController5 ??= TextEditingController(text: widget.leaveRecordId['passport_withdrawal_date']);
     
     
      _model.textController7 ??= TextEditingController(text: widget.leaveRecordId['leaves_comments']);
     

     


    _model.textController8??= TextEditingController(text: widget.leaveRecordId['duration'].toString());
    
    

    _selectedAbsenceReason=widget.leaveRecordId['leave_reason'];
    _selectedAbsenceType=widget.leaveRecordId['leave_type'];
     _selectedAbsenceCategory=widget.leaveRecordId['category'];
    _selectedRequestAirticket=widget.leaveRecordId['request_for_airticket'];

    
     print('Business Group: ${_model.textController1.text}');
    print('Reason : $_selectedAbsenceCategory');
    print('Date of Exception: ${_model.textController2.text}');


    print('Medical Report ID: ${widget.leaveRecordId}');
   
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



 Future<void> editexceptionRecord(int exceptionId, Map<String, dynamic> visaData, String jwtToken) async  {


  
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

  final url = Uri.parse('$apiBaseUrl/hr/api/leave-reimbursement/$exceptionId');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt3',
  };
  visaData['request_for_airticket']=_selectedRequestAirticket;
  visaData['leave_reason']=_selectedAbsenceReason;
  visaData['leave_type']=_selectedAbsenceType;
  visaData['category']=_selectedAbsenceCategory;

  final body = jsonEncode(visaData);

  try {
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Medical record update successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to HistoryBalanceCopyWidget
      Navigator.pop(context);
    } else {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update Medical record.'),
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
    return Scaffold(
       backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
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
                MaterialPageRoute(builder: (context) => const LeaveManagementHistoryWidget()),
              );

            },
            
          ),
          title: Text(
            'Update Leave Management',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 0,
                ),
          ),
          actions: [
          
        ],
          centerTitle: false,
          elevation: 2,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // padding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                        'Employee ID',
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
                      controller:  _model.textController1,
                      
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Business Group ',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
                    )
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
                      
              
                  
                    Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Text(
                    'Leave Type',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 12, 0.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedAbsenceType,
                  items: _absenceType.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: SizedBox(
                        width: 200, // Set the desired maximum width here
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
                        ),
                      ),
                    ),
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAbsenceType = newValue;
                      _selectedAbsenceCategory = _absenceCategory[newValue];

                      print('Selected Reason: $_selectedAbsenceType');
                      // You can add additional logic here if needed
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select Leave Type',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
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
                      Icons.logout_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 16,
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
                ),
              ),
                    

                     Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Leave Category',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0,
                              fontSize: 12,
                              color: Colors.black
                            ),
                      ),
                    ),
                  ),
                  // Display the selected absence category value directly in the UI
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
                              Icons.category,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      size: 18,
                                    ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Text(_selectedAbsenceCategory??'', 
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
                    'Leave Reason',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 12, 0.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedAbsenceReason,
                  items: _leaveReasonType.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: SizedBox(
                        width: 200, // Set the desired maximum width here
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
                        ),
                      ),
                    ),
                  ).toList(),
                  onChanged: (newValue) {
                                  setState(() {
                                    _selectedAbsenceReason = newValue as String;
                                    print('Selected Type of Claim: $_selectedAbsenceReason');
                                  });
                                },
                  decoration: InputDecoration(
                    hintText: 'Leave Reason',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
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
                      Icons.join_left_outlined,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 16,
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
                ),
                      
              ),
                  
                Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Start-Date',
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
                      controller:  _model.textController2,
                      
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd ',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                                  Icons.date_range_outlined,
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
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
                    )
                  ),




                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'End-Date',
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
                      controller:  _model.textController3,
                      
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
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                                  Icons.date_range_outlined,
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
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
                    )
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Total Days',
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
                      controller:  _model.textController8,
                      
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Total Days',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                                  Icons.view_day_outlined,
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
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
                    )
                  ),


                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Replaced By',
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
                      controller:  _model.textController4,
                      
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Repalced By',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                                  Icons.person,
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
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
                    )
                  ),

                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Passport Withdrawal Date',
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
                      controller:  _model.textController5,
                      
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'passport Withdrawal Date ',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                                  Icons.date_range_outlined,
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
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
                    )
                  ),



                  Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Text(
                    'Request For Airticket',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      letterSpacing: 0,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
                    Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 12, 0.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedRequestAirticket,
                  items: _requestAirticket.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: SizedBox(
                        width: 200, // Set the desired maximum width here
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
                        ),
                      ),
                    ),
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRequestAirticket = newValue;

                      print('Selected Reason: $_selectedAbsenceType');
                      // You can add additional logic here if needed
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Request for Airticket',
                    hintStyle: FlutterFlowTheme.of(context)
                        .labelMedium
                        .override(
                          fontFamily: 'Poppins',
                          fontSize: 12,
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
                      Icons.airplane_ticket,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 16,
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
                ),
              ),

                   
                    
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child:  Text(
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                    child: TextFormField(
                      controller:  _model.textController7,
                    
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14
                                ),
                        hintText: 'Comment',
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
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
                          Icons.comment,
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
                                onPressed: () async {
                                  
 final token = await getAuthToken();

                        final exceptionId = widget.leaveRecordId['id']; // Assuming you have access to the contract ID
                        final visaData = {
                            'emp_id': _model.empId,
                            'username': _model.username,
                            'department': _model.department,
                            
                            'email': _model.email,
                            'group': _model.textController1.text,  
                            'start_date': _model.textController2.text,  
                            'end_date': _model.textController3.text,  
                            'replaced_by': _model.textController4.text,  
                            'passport_withdrawal_date': _model.textController5.text,  
                            'leaves_comments': _model.textController7.text,                 
                            'duration': (_model.textController8.text).toString(),
                             // Convert to int
                             
                            'leave_type': _selectedAbsenceType,
                            'leave_reason': _selectedAbsenceReason,
                            'request_for_airticket': _selectedRequestAirticket,
                            'category': _selectedAbsenceCategory,// Convert to int
                          
                 
                          
                        };
                        
                        final jwtToken = token; // Assuming this retrieves the JWT token
                 
                        try {
                          await editexceptionRecord(exceptionId, visaData, jwtToken!);
                          
                          // Navigate to next page if contract is updated successfully
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LeaveManagementHistoryWidget(),
                            ),
                          );
                        } catch (e) {
                          print('Error: $e');
                          // Show error pop-up
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update medical record. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                                text: 'Update',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).oxfordBlue,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
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
    );
  }
}
































