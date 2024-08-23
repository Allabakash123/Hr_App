import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/medicalReport/history_balance_copy_widget.dart';
import 'package:team_c/medicalReport/medical_report_model.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_util.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/leaveManagement/leave_management_history_widget.dart';
import 'package:team_c/utils/const_api.dart';

class EditMedicalReportWidget extends StatefulWidget {
 final Map<String, dynamic>  medicalReportId;

  const EditMedicalReportWidget({Key? key, required this.medicalReportId})
      : super(key: key);

  @override
  State<EditMedicalReportWidget> createState() =>
      _EditMedicalReportWidgetState();
}


class _EditMedicalReportWidgetState extends State<EditMedicalReportWidget> {
  
    late MedicalReportModel _model;
  
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  
  
  


  bool _isLoading = false;

  _EditMedicalReportWidgetState(){
      _selectedValue=_tyoeOfClaim[0];
      _selectedReasonValue=_reasonClaim[0];

  }


 final _tyoeOfClaim=['Normal Medical Fees','Urgent Medical Fees'];
 final _reasonClaim=['New','Renewal'];
  String ? _selectedValue;
  String ? _selectedReasonValue;

  @override
  void initState() {
    super.initState();
    
    _model = createModel(context, () => MedicalReportModel());
  
    _model.empId =  widget.medicalReportId['emp_id'];
    _model.username =  widget.medicalReportId['username'];
    _model.email =  widget.medicalReportId['email']; // Initialize empId here
    _model.department = widget.medicalReportId['department'];
    
    _model.textController1 ??= TextEditingController(text: widget.medicalReportId['group']);
    
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController(text: widget.medicalReportId['amount_aed'].toString());
    
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??=TextEditingController(text: widget.medicalReportId['medicalReimbursement_comments']);
    
    _model.textFieldFocusNode3 ??= FocusNode();


    _selectedValue=widget.medicalReportId['type_of_claim'];
    _selectedReasonValue=widget.medicalReportId['medicalreimbursement_reason'];

    
     print('Business Group: ${_model.textController1.text}');
    print('Reason : $_selectedReasonValue');
    print('Date of Exception: ${_model.textController2.text}');


    print('Medical Report ID: ${widget.medicalReportId}');
   
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

  
Future<void> editexceptionRecord(int? exceptionId, Map<String, dynamic> visaData, String jwtToken) async {

 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

  final url = Uri.parse('$apiBaseUrl/hr/api/medical-reimbursement/${exceptionId ?? ''}');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt3',
  };
  visaData['type_of_claim']=_selectedValue;
  visaData['medicalreimbursement_reason']=_selectedReasonValue;

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
                MaterialPageRoute(builder: (context) => const HistoryBalanceCopyWidget()),
              );

            },
            
          ),
          title: Text(
            'Update Medical Reimbursement',
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
                                      )
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
                                      )
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
                                        fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                      fontSize: 14
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                  child: Text(
                    'Reason',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      letterSpacing: 0,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
                    Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                child: DropdownButtonFormField<String>(
                  value: _selectedReasonValue,
                  items: _reasonClaim.map(
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
                      _selectedReasonValue = newValue;
                      print('Selected Reason: $_selectedReasonValue');
                      // You can add additional logic here if needed
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select Reason',
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                  child: Text(
                    'Type of Medical Claim',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      letterSpacing: 0,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
                    Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                child:  DropdownButtonFormField<String>(
                                value: _selectedValue,
                                items: _tyoeOfClaim.map(
                                (e) => DropdownMenuItem(child:Text(e),value:e,)
                            
                                ).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedValue = newValue as String;
                                    print('Selected Type of Claim: $_selectedValue');
                                  });
                                },
                                icon:const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey
                                ),
                  decoration: InputDecoration(
                    hintText: 'Select Type of Medical Claim',
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
                      Icons.medical_information,
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
                   
                  },
                ),
              ),
                

                    
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child:  Text(
                                'Amount(AED)',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                      letterSpacing: 0,
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
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14
                                ),
                        hintText: 'Amount(AED)',
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                    child: TextFormField(
                      controller: _model.textController3,
                      
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
                      textAlign: TextAlign.start,
                      // validator:
                      //     _model.textController2Validator.asValidator(context),
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
  final exceptionId = widget.medicalReportId['id']; // Cast to int?
  if (exceptionId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invalid medical report ID'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }
  
  final visaData = {
    'emp_id': _model.empId,
    'username': _model.username,
    'department': _model.department,
    'email': _model.email,
    'group': _model.textController1.text,                
    'amount_aed': _model.textController2.text,
    'medicalReimbursement_comments': _model.textController3.text,
    'type_of_claim': _selectedValue,
    'medicalreimbursement_reason': _selectedReasonValue,
  };
  
  final jwtToken = token;
  
  if (jwtToken == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Authentication token not found'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    await editexceptionRecord(exceptionId, visaData, jwtToken);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryBalanceCopyWidget(),
      ),
    );
  } catch (e) {
    print('Error: $e');
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
