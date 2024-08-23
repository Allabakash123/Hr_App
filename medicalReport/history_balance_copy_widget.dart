import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/medicalReport/HistoryBalanceCopyModel.dart';
import 'package:team_c/medicalReport/edit_medical_report_widget.dart';
import 'package:team_c/medicalReport/medical_report_widget.dart';
import 'package:team_c/utils/const_api.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';



class HistoryBalanceCopyWidget extends StatefulWidget {
  const HistoryBalanceCopyWidget({super.key});

  @override
  State<HistoryBalanceCopyWidget> createState() => _HistoryBalanceCopyWidgetState();
}

class _HistoryBalanceCopyWidgetState extends State<HistoryBalanceCopyWidget> {
  late HistoryBalanceCopyModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic> medicalApplications = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isEyeOpen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryBalanceCopyModel());
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

    const String apiUrl = '$apiBaseUrl/hr/api/medical-data';
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
        medicalApplications = responseData;
        rowsPerPage = rowsPerPage > 0 ? rowsPerPage : PaginatedDataTable.defaultRowsPerPage;
      });
    } else {
      print('Failed to fetch leave applications: ${response.statusCode}');
    }
  }

  Future<void> deleteMedicalReport(int medicalReportId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiBaseUrl/hr/api/delete-medical-reimbursement/$medicalReportId'),
        headers: {
          'Authorization': 'Bearer $currentAuthenticationToken',
        },
      );

      if (response.statusCode == 200) {
        print('Medical report deleted successfully');
        fetchLeaveApplications();
      } else {
        print('Failed to delete medical report: ${response.body}');
      }
    } catch (e) {
      print('Error deleting medical report: $e');
    }
  }

  Future<Map<String, dynamic>> fetchMedicalRecord(int exceptionId) async {
    
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;
    final String apiUrl = '$apiBaseUrl/hr/api/data-medical-reimbursement/$exceptionId';

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
                      child: const Text('Medical Reimbursement Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),  Row(
                    children: [
                      IconButton(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Icon(
                            Icons.edit_outlined,
                            color: employeeData['medicalReimbursement_status'] == 'approved' || employeeData['medicalReimbursement_status'] == 'rejected'
                                ? const Color.fromARGB(255, 229, 111, 111)
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        onPressed: () async {
                          int.parse(employeeData['id'].toString());
                          final exceptionId = employeeData['id'];
                          final fetchedData = await fetchMedicalRecord(exceptionId);
                          print('Fetched data of Medical: $fetchedData');
                          if (employeeData['medicalReimbursement_status'] != 'approved' && employeeData['medicalReimbursement_status'] != 'rejected') {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => EditMedicalReportWidget(
                                  medicalReportId: fetchedData,
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
                            color: employeeData['medicalReimbursement_status'] == 'approved' || employeeData['medicalReimbursement_status'] == 'rejected'
                                ? const Color.fromARGB(255, 229, 111, 111)
                                : FlutterFlowTheme.of(context).primaryText,
                            size: 24,
                          ),
                        ),
                        onPressed: () {
                          int medicalReportId = int.parse(employeeData['id'].toString());
                          if (employeeData['medicalReimbursement_status'] != 'approved' && employeeData['medicalReimbursement_status'] != 'rejected') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text('Are you sure you want to delete this medical report?'),
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
                            child: Icon(Icons.note, color: Colors.black, size: 16),
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
                                      '${employeeData['medicalreimbursement_reason']}',
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
                            child: Icon(Icons.assignment, color: Colors.black, size: 16),
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
                                        'Types Of Claim',
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
                                      '${employeeData['type_of_claim']}',
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
                            child: Icon(Icons.monetization_on, color: Colors.black, size: 16),
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
                                        'Amount AED',
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
                                      '${employeeData['amount_aed']}',
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
                                        'status',
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
                                      '${employeeData['medicalReimbursement_status']}',
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
                                      '${employeeData['medicalReimbursement_applied_date']}',
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MedicalReportWidget(token: token)),
                                    );
                                  }
          },
          ),
          title: Text(
            'History of Medical Reports',
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
            style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          Text(
            medicalReport['medicalReimbursement_status'].toString(),
            style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          Text(
            medicalReport['medicalReimbursement_applied_date'].toString(),
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