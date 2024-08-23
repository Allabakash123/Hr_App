
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_widget.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_util.dart';
import 'package:team_c/utils/const_api.dart';

import 'labour_contract_amendment_reque_detail_model.dart';
import 'labour_contract_amendment_reque_edit.dart';

class LabourHistoryBalanceCopyWidget extends StatefulWidget {
  const LabourHistoryBalanceCopyWidget({Key? key}) : super(key: key);

  @override
  State<LabourHistoryBalanceCopyWidget> createState() =>
      _LabourHistoryBalanceCopyWidgetState();
}

class _LabourHistoryBalanceCopyWidgetState
    extends State<LabourHistoryBalanceCopyWidget> {
  late LabourHistoryBalanceCopyModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> _labourContracts = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isEyeOpen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LabourHistoryBalanceCopyModel());
    _fetchLabourContracts();
  }
   void LabourContractApplications() {
      _fetchLabourContracts();
  }

  void resetEyeOpen() {
    setState(() {
      isEyeOpen = false;
    });
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


   Future<void> _fetchLabourContracts() async {
    final token = await getAuthToken();
    final String? jwt3 = token;
    const String apiUrl = '$apiBaseUrl/hr/api/labour-contract-get';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    },
  );

    if (response.statusCode == 200) {
      setState(() {
        _labourContracts = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to fetch labour contracts: ${response.statusCode}');
    }
  }

 Future<void> _deleteLabourContract(int contractId) async {
      final token = await getAuthToken();

  final String? jwt3 = token;
  final String apiUrl = '$apiBaseUrl/hr/api/labour-contract-delete/$contractId';

  final response = await http.delete(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    },
  );

  if (response.statusCode == 200) {
    // Remove the deleted contract from the list
    setState(() {
      _labourContracts.removeWhere((contract) => contract['id'] == contractId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Labour contract deleted successfully'),
      ),
    );
  } else {
    // Show appropriate error message based on response status code
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to delete labour contract'),
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchLabourContractId(int visaId) async {
      final token = await getAuthToken();

  final String? jwt3 = token;
  final String apiUrl = '$apiBaseUrl/hr/api/labour-contract-get/$visaId';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch exception data');
  }
}

  void _showEmployeeDetails(Map<String, dynamic> employeeData) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 350,
          width: 400,
          child: Column(
            children: [
              // Fixed header section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text('Labour contract Details', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  Expanded(
                      child: const Text('Labour Contract Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),

                  Row(
                    children: [
                      IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Icon(
                            Icons.edit_outlined,
                            color: employeeData['labourContract_status'] == 'approved' || employeeData['labourContract_status'] == 'rejected'
                                ? const Color.fromARGB(255, 229, 111, 111)
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        onPressed: () async {
                          int.parse(employeeData['id'].toString());
                          final exceptionId = employeeData['id'];
                          final fetchedData = await fetchLabourContractId(exceptionId);
                          print('Fetched data of Medical: $fetchedData');
                          if (employeeData['labourContract_status'] != 'approved' && employeeData['labourContract_status'] != 'rejected') {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => LabourContractAmendmentRequeEditWidget(
                                   labourContract    : employeeData,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Icon(
                            Icons.delete_outlined,
                            color: employeeData['labourContract_status'] == 'approved' || employeeData['labourContract_status'] == 'rejected'
                                ? const Color.fromARGB(255, 229, 111, 111)
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        onPressed: () {
                          int medicalReportId = int.parse(employeeData['id'].toString());
                          if (employeeData['labourContract_status'] != 'approved' && employeeData['labourContract_status'] != 'rejected') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text('Are you sure you want to delete this Labour contract?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _deleteLabourContract(medicalReportId);
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      ),
                      GestureDetector(
                         onTap: () {
                            resetEyeOpen();
                            Navigator.of(context).pop();
                          },
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 1,),
              SizedBox(height: 5,),
              // Scrollable details section
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.badge, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Employee ID',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['emp_id']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ), 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.person, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Employee Name',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['username']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.business, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Department',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['department']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.email, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Email',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['email']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                       Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.date_range, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Amendment Date',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['amendment_date']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.info, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Reason',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['labourcontract_reason']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.info, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Status',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['labourContract_status']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.calendar_today, color: Colors.black, size: 16),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 0,
                                    runSpacing: 0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Text(
                                        'Applied On',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                  child: Text(
                                    ':',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                    child: Text(
                                      '${employeeData['labourContract_applied_date']}',
                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  }
    

void _handleEyeIconPressed(int index) {
    setState(() {
      isEyeOpen = !isEyeOpen;
    });
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
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
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LabourContractAmendmentRequeWidget(token: token),
                  ),
                );
                  }
            },
          ),
          title: Text(
            'History of Labour Contract',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Urbanist',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
          // centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    width: 800, // Specify the width of the table
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey[300]!, // Adjust border color as needed
                          width: 1, // Adjust border width as needed
                        ),
                      ),
                      child: PaginatedDataTable(
                       
                        columns: [
                          DataColumn(
                            label: Text(
                              'Employee ID',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).white,
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Applied On',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).white,
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'More',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).white,
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                        ],
                        source: MedicalDataTableSource(
                          medicalApplications: _labourContracts,
                          onDelete: (index) {
                            final medicalReport = _labourContracts[index];
                            _deleteLabourContract(medicalReport['id']);
                          },
                          onTapDetails: (index) {
                            final medicalReport = _labourContracts[index];
                            _showEmployeeDetails(medicalReport);
                          },isEyeOpen: isEyeOpen,
                          handleEyeIconPressed: _handleEyeIconPressed,
                        ),
                        onRowsPerPageChanged: (newRowsPerPage) {
                          setState(() {
                            rowsPerPage = newRowsPerPage ?? PaginatedDataTable.defaultRowsPerPage;
                            rowsPerPage = rowsPerPage > 0 ? rowsPerPage : PaginatedDataTable.defaultRowsPerPage;
                          });
                        },
                        rowsPerPage: rowsPerPage,
                        columnSpacing: 15.0,
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 44, 10, 10)),
                        
                        dataRowHeight: 48.0,
                        headingRowHeight: 56.0,
                        horizontalMargin: 10.0,
                        showCheckboxColumn: false,
                      ),
                    ),
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
class MedicalDataTableSource extends DataTableSource {
  final List<dynamic> medicalApplications;
  final Function(int) onDelete;
  final Function(int) onTapDetails;
  late final bool isEyeOpen;
  final Function(int) handleEyeIconPressed;
                                            
  MedicalDataTableSource({
    required this.medicalApplications,
    required this.onDelete,
    required this.onTapDetails,
    required this.isEyeOpen, 
    required this.handleEyeIconPressed,
  });

  

  @override
  DataRow getRow(int index) {
    final medicalReport = medicalApplications[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            medicalReport['emp_id'].toString(),
            style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          Text(
            medicalReport['labourContract_status'].toString(),
            style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          Text(
            medicalReport['labourContract_applied_date'].toString(),
            style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          IconButton(
            icon: Icon(
              isEyeOpen ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {
               handleEyeIconPressed(index);
              onTapDetails(index);
            },
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => medicalApplications.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}