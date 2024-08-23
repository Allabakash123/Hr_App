

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employeereimbusement/employeereimbusement_widget.dart';
import 'package:team_c/historybalance/ediemployeereimbursememnt.dart';
import 'package:team_c/historybalance/historybalancecopymodel.dart';
import 'package:team_c/utils/const_api.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


export 'HistoryBalanceCopyModel.dart';

class EmployeeHistoryBalanceCopyWidget extends StatefulWidget {
  const EmployeeHistoryBalanceCopyWidget({super.key});

  @override
  State<EmployeeHistoryBalanceCopyWidget> createState() =>
      EmployeeHistoryBalanceCopyWidgetState();
}

class EmployeeHistoryBalanceCopyWidgetState extends State<EmployeeHistoryBalanceCopyWidget> {
  late EmployeeHistoryBalanceCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Map<String, dynamic>> medicalApplications = [];
  String filterValue = '';
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isEyeOpen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmployeeHistoryBalanceCopyModel());
    fetchLeaveApplications();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void updateMedicalApplications() {
      fetchLeaveApplications();
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
  
  Future<void> fetchLeaveApplications() async {
   

 final token = await getAuthToken();
  
  
  final String? jwt3 = token;
    const String apiUrl = '$apiBaseUrl/hr/api/employee_reimbursement';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt3',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        medicalApplications = List<Map<String, dynamic>>.from(responseData);
        print(medicalApplications);
      });
    } else {
      // Handle API error response
      print('Failed to fetch leave applications: ${response.statusCode}');
    }
  }


  Future<void> deleteMedicalReport(int medicalReportId) async {
    

 final token = await getAuthToken();
  
  
  final String? jwt3 = token;
  try {
    final response = await http.delete(
      Uri.parse('$apiBaseUrl/hr/api/delete-employee_reimbursement/$medicalReportId'),
      headers: {
        'Authorization': 'Bearer $jwt3',
      },
    );

    if (response.statusCode == 200) {
      print('Medical report deleted successfully');
      // Refresh the list of medical reports
      fetchLeaveApplications();
    } else {
      // Handle error response
      print('Failed to delete medical report: ${response.body}');
    }
  } catch (e) {
    // Handle network or server errors
    print('Error deleting medical report: $e');
  }
}



Future<Map<String, dynamic>> fetchEmployeeData(int visaId) async {
final token = await getAuthToken();
  
  
  final String? jwt3 = token;
  final String apiUrl = '$apiBaseUrl/hr/api/data-employee-reimbursement/$visaId';

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
                  Expanded(
                      child: const Text('Employee Reimbursement Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ), Row(
                    children: [
                      IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Icon(
                            Icons.edit_outlined,
                            color: employeeData['employeereimbursement_status'] == 'approved' || employeeData['employeereimbursement_status'] == 'rejected'
                                ? const Color.fromARGB(255, 229, 111, 111)
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        onPressed: () async {
                          int.parse(employeeData['id'].toString());
                          final exceptionId = employeeData['id'];
                          final fetchedData = await fetchEmployeeData(exceptionId);
                          print('Fetched data of Medical: $fetchedData');
                          if (employeeData['employeereimbursement_status'] != 'approved' && employeeData['employeereimbursement_status'] != 'rejected') {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => EmployeeReimbursementEditWidget(
                                   reimbursement    : employeeData,
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
                            color: employeeData['employeereimbursement_status'] == 'approved' || employeeData['employeereimbursement_status'] == 'rejected'
                                ? const Color.fromARGB(255, 229, 111, 111)
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        onPressed: () {
                          int medicalReportId = int.parse(employeeData['id'].toString());
                          if (employeeData['employeereimbursement_status'] != 'approved' && employeeData['employeereimbursement_status'] != 'rejected') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text('Are you sure you want to delete this Document Visa?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        deleteMedicalReport(medicalReportId);
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
                            child: Icon(Icons.group, color: Colors.black, size: 16),
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
                                        'Group',
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
                                      '${employeeData['group']}',
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
                            child: Icon(Icons.type_specimen_rounded, color: Colors.black, size: 16),
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
                                        'Reimbursement Type',
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
                                      '${employeeData['reimbursement_type']}',
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
                            child: Icon(Icons.money, color: Colors.black, size: 16),
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
                                        'Enter Amount',
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
                                      '${employeeData['enter_amount']}',
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
                                      '${employeeData['employeereimbursement_status']}',
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
                                      '${employeeData['employeereimbursement_applied_date']}',
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EmployeeReimbursementWidget(token: token)),
                                    );
                                  }
                                },

          ),
          title: Text(
            'History of Employee Reimbursement',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Urbanist',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        
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
                              'Group',
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
                          medicalApplications: medicalApplications,
                          onDelete: (index) {
                            final medicalReport = medicalApplications[index];
                            deleteMedicalReport(medicalReport['id']);
                          },
                          onTapDetails: (index) {
                            final medicalReport = medicalApplications[index];
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
            style: const TextStyle(fontFamily: 'Readex Pro'),
          ),
        ),
          DataCell(
          Text(
            medicalReport['group'].toString(),
            style: const TextStyle(fontFamily: 'Readex Pro'),
          ),
        ),
        DataCell(
          Text(
            medicalReport['employeereimbursement_status'].toString(),
            style: const TextStyle(fontFamily: 'Readex Pro'),
          ),
        ),
        DataCell(
          Text(
            medicalReport['employeereimbursement_applied_date'].toString(),
            style: const TextStyle(fontFamily: 'Readex Pro'),
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

