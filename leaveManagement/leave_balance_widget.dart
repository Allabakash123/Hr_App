import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/utils/const_api.dart';

class LeaveBalanceWidget extends StatefulWidget {
  const LeaveBalanceWidget({Key? key}) : super(key: key);

  @override
  State<LeaveBalanceWidget> createState() => _LeaveBalanceWidgetState();
}

class _LeaveBalanceWidgetState extends State<LeaveBalanceWidget> {
  late List<Map<String, dynamic>> leaveApplications = [];

  @override
  void initState() {
    super.initState();
    fetchLeaveApplications();
  }

  Future<void> fetchLeaveApplications() async {
    const String apiUrl = '$apiBaseUrl/api/leave-data';
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $currentAuthenticationToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        leaveApplications = List<Map<String, dynamic>>.from(responseData);
        print(leaveApplications);
      });
    } else {
      // Handle API error response
      print('Failed to fetch leave applications: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const EmployepageWidget()),
              // );
            },
          ),
          title: Text(
            'Leave Balance',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Employee Name: ${leaveApplications.isNotEmpty ? leaveApplications[0]['employee_name'] : ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                
                        const SizedBox(height: 10),
                        const Text(
                          'Total Leaves: 100',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                           
                            headingRowHeight: 56,
                            columnSpacing: 20,
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => FlutterFlowTheme.of(context).nyanza),
                      border: TableBorder.all(borderRadius:const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),),
                  columns:  [
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Emp Id',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Leave Type',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                    
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Start-Date',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                    
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('End-Date',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                    
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Status',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                    
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Total Days',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                    
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Leave Balance',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                         
                    DataColumn(label: DefaultTextStyle.merge(softWrap: true,child: Text('Applied Date',style: FlutterFlowTheme.of(context).labelLarge.override(fontFamily: 'Poppins',letterSpacing: 0,),))),
                              
                          
                    
                  ],
                  rows: leaveApplications.map<DataRow>((application) {
                    return DataRow(
                      cells: [
                        DataCell(Text(application['employee_id'])),
                        DataCell(Text(application['leave_type'])),
                        DataCell(Text(application['start_date'])),
                        DataCell(Text(application['end_date'])),
                        DataCell(Text(application['status'])),
                        DataCell(Text(application['duration'].toString())),
                        DataCell(Text(application['leave_balance'].toString())),
                        DataCell(Text(application['applied_date'])),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

