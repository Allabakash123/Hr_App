

import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_detail.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_widget_model.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LabourContractAmendmentRequeEditWidget extends StatefulWidget {
  final Map<String, dynamic> labourContract;
  const LabourContractAmendmentRequeEditWidget({
    Key? key,
    required this.labourContract,
  }) : super(key: key);

  @override
  _LabourContractAmendmentRequeEditWidgetState createState() =>
      _LabourContractAmendmentRequeEditWidgetState();
}

class _LabourContractAmendmentRequeEditWidgetState
    extends State<LabourContractAmendmentRequeEditWidget> {
  late LabourContractAmendmentRequeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final _amendementRequest = [
    'Name Change',
    'Position Change',
    'Position and Salary Change',
    'Salary Change'
  ];
  String? _selectedAmendementRequest;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabourContractAmendmentRequeModel());
    _model.textController1 ??=
        TextEditingController(text: widget.labourContract['group']);
    _model.textFieldFocusNode1 ??= FocusNode();

    // Check if the initial value is present in the list
    final initialValue = widget.labourContract['labourcontract_reason'];
    if (_amendementRequest.contains(initialValue)) {
      _selectedAmendementRequest = initialValue;
    } else {
      // Set a default value if the initial value is not present
      _selectedAmendementRequest =
          _amendementRequest.isNotEmpty ? _amendementRequest.first : null;
    }

    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textController3 ??=
        TextEditingController(text: widget.labourContract['amendment_date']);
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textController4 ??=
        TextEditingController(text: widget.labourContract['labourContract_comments']);
    _model.textFieldFocusNode4 ??= FocusNode();
    _model.empId = widget.labourContract['emp_id'];
    _model.username = widget.labourContract['username'];
    _model.email = widget.labourContract['email'];
    _model.department = widget.labourContract['department'];
    print('Date: ${_model.textController3.text}');
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


  Future<void> editLabourContract(
      int contractId, Map<String, dynamic> contractData, String jwtToken) async {
    
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

    final url = Uri.parse('http://127.0.0.1:8000/hr/api/labour-contract/$contractId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    };
    contractData['labourcontract_reason'] = _selectedAmendementRequest;
    final body = jsonEncode(contractData);
    try {
      final response = await http.put(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Labour contract updated successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacementNamed('HistoryBalanceCopyWidget');
      } else {
         print('Failed to edit Labour request: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update labour contract.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
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
          backgroundColor:  FlutterFlowTheme.of(context).oxfordBlue,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LabourHistoryBalanceCopyWidget()),
              );
            },
          ),
          title: Text(
            'Update Labour Contract ',
            textAlign: TextAlign.start,
           style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 0,
                ),
          ),
          centerTitle: false,
          elevation: 2,
        ),
        body:  _isLoading
         ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 08, 0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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
                                  const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14
                                  ),
                                  hintText: 'Business Group',
                                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
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
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Business Group is required';
                                //   }
                                //   return null;
                                // },
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
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
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 12, 0.0),
                    child: Text(
                      'Reason For Amendment',
                       style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                   child: DropdownButtonFormField<String>(
                      value: _selectedAmendementRequest,
                      hint: const Text('Select a reason'),
                      items: _amendementRequest.map(
                        (e) => DropdownMenuItem(
                          child: Text(e, style: const TextStyle(fontFamily: 'Poppins')),
                          value: e,
                        ),
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
                                        fontSize: 12,
                                        letterSpacing: 0,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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
                                  fontWeight: FontWeight.w200,
                                    fontSize: 14
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
                          Icons.date_range,
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
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
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14
                                  ),
                          hintText: 'Comment',
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
                        textAlign: TextAlign.start,
                        validator:
                            _model.textController4Validator.asValidator(context),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0,),
                  Center(
                    child: FFButtonWidget(
                        onPressed: () async {
                          final token = await getAuthToken();
                          final contractId = widget.labourContract['id']; // Assuming you have access to the contract ID
                          final contractData = {
                            'emp_id': _model.empId,
                            'username': _model.username,
                            'department': _model.department,
                            'email': _model.email,
                            'group': _model.textController1.text,
                            'labourcontract_reason': _model.textController2.text,
                            'amendment_date': _model.textController3.text,
                            'labourContract_comments': _model.textController4.text,
                          };
                          final jwtToken = token; // Assuming this retrieves the JWT token
                          try {
                            await editLabourContract(contractId, contractData, jwtToken!);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LabourHistoryBalanceCopyWidget(),
                              ),
                            );
                          } catch (e) {
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to update labour contract. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        text: 'Update',
                        options: FFButtonOptions(
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color:const Color(0xFF002147),
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
      );
  }
}