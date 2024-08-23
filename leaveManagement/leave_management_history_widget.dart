
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/leaveManagement/edit_leave_management.dart';
import 'package:team_c/leaveManagement/leave_management_history_model.dart';
import 'package:team_c/leaveManagement/leave_managment_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/helpers/helper_function.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaveManagementHistoryWidget extends StatefulWidget {
  const LeaveManagementHistoryWidget({super.key});
  @override
  State<LeaveManagementHistoryWidget> createState() =>
      _LeaveManagementHistoryWidgetState();
}

class _LeaveManagementHistoryWidgetState
    extends State<LeaveManagementHistoryWidget> {
  late LeaveManagementHistoryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late List<Map<String, dynamic>> leaveApplications = [];
  int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool isEyeOpen = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeaveManagementHistoryModel());
    fetchLeaveApplications();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> fetchLeaveApplications() async {
  final token = await getAuthToken();
  
  
  final String? jwt = token;

  const String apiUrl = '$apiBaseUrl/hr/api/leave-data';
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> responseData = jsonDecode(response.body);
    setState(() {
      leaveApplications = List<Map<String, dynamic>>.from(responseData);
      rowsPerPage =
          rowsPerPage > 0 ? rowsPerPage : PaginatedDataTable.defaultRowsPerPage;
    });
  } else {
    // Handle API error response
    print('Failed to fetch leave applications: ${response.statusCode}');
  }
}

  Future<void> deleteLeaveRecord(int leaveRecordId) async {
     final token = await getAuthToken();
  
  
  final String? jwt3 = token;

  try {
    final response = await http.delete(
      Uri.parse('$apiBaseUrl/hr/api/delete-leave_record/$leaveRecordId'),
      headers: {
        'Authorization': 'Bearer $jwt3',
      },
    );

    if (response.statusCode == 200) {
      print('Leave record deleted successfully');
      // Refresh the list of leave records
      // fetchLeaveApplications();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LeaveManagementHistoryWidget()),
      );
    } else {
      // Handle error response
      print('Failed to delete leave record: ${response.body}');
    }
  } catch (e) {
    // Handle network or server errors
    print('Error deleting leave record: $e');
  }
}

  void resetEyeOpen() {
    setState(() {
      isEyeOpen = false;
    });
  }

  void updateLeaveApplications() {
    fetchLeaveApplications();
  }

  void _showEmployeeDetails(Map<String, dynamic> employeeData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: THelperFunctions.screenHeight()*0.5,
            width: THelperFunctions.screenWidth()*4.0,
            child: Column(
              children: [
                // Fixed header section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text('Leave Management Details',
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
                              color: employeeData['leaves_status'] == 'approved' ||
                                      employeeData['leaves_status'] == 'rejected'
                                  ? const Color.fromARGB(255, 229, 111, 111)
                                  : FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                          ),
                          onPressed: () async {
                            int.parse(employeeData['id'].toString());
                            final exceptionId = employeeData['id'];
                            final fetchedData =
                                await fetchLeaveData(exceptionId);
                            print('Fetched data of Medical: $fetchedData');
                            if (employeeData['leaves_status'] != 'approved' &&
                                employeeData['leaves_status'] != 'rejected') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeaveEditWidget(
                                    leaveRecordId: fetchedData,
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
                              color: employeeData['leaves_status'] == 'approved' ||
                                      employeeData['leaves_status'] == 'rejected'
                                  ? const Color.fromARGB(255, 229, 111, 111)
                                  : FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                          ),
                          onPressed: () {
                            int leaveRecordId =
                                int.parse(employeeData['id'].toString());
                            if (employeeData['leaves_status'] != 'approved' &&
                                employeeData['leaves_status'] != 'rejected') {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Deletion'),
                                    content: const Text(
                                        'Are you sure you want to delete this leave record?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          deleteLeaveRecord(leaveRecordId);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
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
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(height: 5),
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
                                child: Icon(Icons.badge,
                                    color: Colors.black, size: 16),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Wrap(
                                        spacing: 0,
                                        runSpacing: 0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Text(
                                            'Employee Id',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional
                                          .fromSTEB(0, 0, 8, 0),
                                      child: Text(
                                        ':',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 12, 0),
                                        child: Text(
                                          '${employeeData['emp_id']}',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
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
                                        'Start Date',
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
                                      '${employeeData['start_date']}',
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
                                        'End Date',
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
                                      '${employeeData['end_date']}',
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
                            child: Icon(Icons.logout_outlined, color: Colors.black, size: 16),
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
                                        'Leave Type',
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
                                      '${employeeData['leave_type']}',
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
                            child: Icon(Icons.view_day_outlined, color: Colors.black, size: 16),
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
                                        'Duration',
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
                                      '${employeeData['duration']}',
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
                            child: Icon(Icons.verified_user, color: Colors.black, size: 16),
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
                                        'Replaced By',
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
                                      '${employeeData['replaced_by']}',
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
                                      '${employeeData['leaves_status']}',
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
                                      '${employeeData['leaves_applied_date']}',
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
      Size screenSize = MediaQuery.of(context).size;
      double appBarHeight = screenSize.height * 0.08;
      double tableHeadingHeight=screenSize.height*0.5; // 8% of screen height
      double baseTextSize = screenSize.width * 0.08;
      double titleFontSize = baseTextSize.clamp(14.0, 20.0); // Clamp between 14 and 20 // 4% of screen width
        return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
       appBar: PreferredSize(
  preferredSize: Size.fromHeight(appBarHeight),
  child: AppBar(
    backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
    automaticallyImplyLeading: false,
    leading: FlutterFlowIconButton(
      borderColor: Colors.transparent,
      borderRadius: 30,
      borderWidth: 1,
      buttonSize: appBarHeight * 0.8,
      icon: Icon(
        Icons.arrow_back_rounded,
        color: Colors.white,
        size: appBarHeight * 0.4,
      ),
      onPressed: () async {
        final token = await getAuthToken();
        if (token != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LeaveWidget(token: token)),
          );
        }
      },
    ),
    title: Text(
      'History of Leave Management',
      style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Urbanist',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: titleFontSize,
          ),
    ),
    elevation: 2,
  ),
),
        body: SingleChildScrollView(
          child: SafeArea(
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
                            color: Colors.black, // Adjust border color
                            width: 1, // Adjust border width
                          ),
                        ),
                        child: PaginatedDataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Employee Id',
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
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
                          source: LeaveDataTableSource(
                            leaveApplications: leaveApplications,
                            onDelete: (index) {
                              final leaveRecord = leaveApplications[index];
                              deleteLeaveRecord(leaveRecord['id']);
                            },
                            onTapDetails: (index) {
                              final leaveRecord = leaveApplications[index];
                              _showEmployeeDetails(leaveRecord);
                            },
                            isEyeOpen: isEyeOpen,
                            handleEyeIconPressed: _handleEyeIconPressed,
                          ),
                          onRowsPerPageChanged: (newRowsPerPage) {
                            setState(() {
                              rowsPerPage = newRowsPerPage ??
                                  PaginatedDataTable.defaultRowsPerPage;
                              rowsPerPage = rowsPerPage > 0
                                  ? rowsPerPage
                                  : PaginatedDataTable.defaultRowsPerPage;
                            });
                          },
                          rowsPerPage: rowsPerPage,
                          columnSpacing: 15.0,
                          headingRowColor: WidgetStateColor.resolveWith(
                              (states) => const Color.fromARGB(255, 109, 82, 82)),
                          dataRowHeight: THelperFunctions.screenHeight()*.075,
                          headingRowHeight: tableHeadingHeight,
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
      ),
    );
  }
}

class LeaveDataTableSource extends DataTableSource {
  final List<dynamic> leaveApplications;
  final Function(int) onDelete;
  final Function(int) onTapDetails;
  final bool isEyeOpen;
  final Function(int) handleEyeIconPressed;

  LeaveDataTableSource({
    required this.leaveApplications,
    required this.onDelete,
    required this.onTapDetails,
    required this.isEyeOpen,
    required this.handleEyeIconPressed,
  });

  @override
  DataRow getRow(int index) {
    final leaveRecord = leaveApplications[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            leaveRecord['emp_id'].toString(),
             style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          Text(
            leaveRecord['leaves_status'].toString(),
            style: const TextStyle(fontFamily: 'Readex pro'),
          ),
        ),
        DataCell(
          Text(
            leaveRecord['leaves_applied_date'].toString(),
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
  int get rowCount => leaveApplications.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}


Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


Future<Map<String, dynamic>> fetchLeaveData(int exceptionId) async {
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;

  final String apiUrl = '$apiBaseUrl/hr/api/data-leave-reimbursement/$exceptionId';

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