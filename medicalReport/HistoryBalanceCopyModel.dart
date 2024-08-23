
import 'package:team_c/flutter_flow/flutter_flow_data_table.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'history_balance_copy_widget.dart' show HistoryBalanceCopyWidget;
import 'package:flutter/material.dart';
class HistoryBalanceCopyModel
    extends FlutterFlowModel<HistoryBalanceCopyWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<dynamic>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:team_c/auth/custom_auth/auth_util.dart';
// import 'package:team_c/medicalReport/HistoryBalanceCopyModel.dart';
// import 'package:team_c/medicalReport/edit_medical_report_widget.dart';
// import 'package:team_c/medicalReport/medical_report_widget.dart';
// import 'package:team_c/utils/const_api.dart';
// import '/flutter_flow/flutter_flow_data_table.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';

// class HistoryBalanceCopyWidget extends StatefulWidget {
//   const HistoryBalanceCopyWidget({super.key});

//   @override
//   State<HistoryBalanceCopyWidget> createState() => _HistoryBalanceCopyWidgetState();
// }

// class _HistoryBalanceCopyWidgetState extends State<HistoryBalanceCopyWidget> {
//   late HistoryBalanceCopyModel _model;
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   List<dynamic> medicalApplications = [];
//   int rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => HistoryBalanceCopyModel());
//     fetchLeaveApplications();
//   }

//   Future<void> fetchLeaveApplications() async {
//     final String? jwt = currentAuthenticationToken;
//     const String apiUrl = '$apiBaseUrl/api/medical-data';
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $jwt',
//       },
//     );
//     if (response.statusCode == 200) {
//       final List<dynamic> responseData = jsonDecode(response.body);
//       setState(() {
//         medicalApplications = responseData;
//         // Ensure rowsPerPage is greater than 0
//         rowsPerPage = rowsPerPage > 0 ? rowsPerPage : PaginatedDataTable.defaultRowsPerPage;
//       });
//     } else {
//       print('Failed to fetch leave applications: ${response.statusCode}');
//     }
//   }

//   Future<void> deleteMedicalReport(int medicalReportId) async {
//     try {
//       final response = await http.delete(
//         Uri.parse('$apiBaseUrl/api/delete-medical-reimbursement/$medicalReportId'),
//         headers: {
//           'Authorization': 'Bearer $currentAuthenticationToken',
//         },
//       );

//       if (response.statusCode == 200) {
//         print('Medical report deleted successfully');
//         fetchLeaveApplications();
//       } else {
//         print('Failed to delete medical report: ${response.body}');
//       }
//     } catch (e) {
//       print('Error deleting medical report: $e');
//     }
//   }

//   Future<Map<String, dynamic>> fetchMedicalRecord(int exceptionId) async {
//     final String? jwt3 = currentAuthenticationToken;
//     final String apiUrl = '$apiBaseUrl/api/data-medical-reimbursement/$exceptionId';

//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $jwt3',
//       },
//     );

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to fetch exception data');
//     }
//   }

//   void _showEmployeeDetails(Map<String, dynamic> employeeData) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Container(
//             height: 350,
//             width: 400,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Employee Details',style: TextStyle(backgroundColor: Colors.brown),),
//                       Row(
//                         children: [
//                           IconButton(
//                             icon: Padding(
//                                   padding: const EdgeInsets.only(bottom: 5.0),
//                                   child: Icon(
//                                     Icons.edit_outlined,
//                                     color: employeeData['status'] == 'approved' || employeeData['status'] == 'rejected'
//                                         ? const Color.fromARGB(255, 229, 111, 111)// Disabled color
//                                         : FlutterFlowTheme.of(context).primaryText,
//                                     size: 24,
//                                   ),
//                                 ),
                           
//                             onPressed:  () async {
//                                 int.parse(employeeData['id'].toString());
//                                 final exceptionId = employeeData['id'];
//                                 final fetchedData = await fetchMedicalRecord(exceptionId);
//                                 print('Fetched data of Medical: $fetchedData');
//                                 if (employeeData['status'] != 'approved' &&
//                                     employeeData['status'] != 'rejected') {
//                                     Navigator.push(context,
//                                       MaterialPageRoute(
//                                         builder: (context) => EditMedicalReportWidget(
//                                         medicalReportId: fetchedData,
//                                     ),
//                                   ),
//                                 );
//                             }} ,
//                           ),
//                           IconButton(
//                             icon: Padding(
//                                   padding: const EdgeInsets.only(bottom: 5.0),
//                                   child: Icon(
//                                     Icons.delete_outlined,
//                                     color: employeeData['status'] == 'approved' || employeeData['status'] == 'rejected'
//                                         ? const Color.fromARGB(255, 229, 111, 111) // Disabled color
//                                         : FlutterFlowTheme.of(context).primaryText,
//                                     size: 24,
//                                   ),
//                                 ),
                          
//                             onPressed: () {
//                                   int medicalReportId =
//                                       int.parse(employeeData['id'].toString());
//                                   if (employeeData['status'] != 'approved' &&
//                                       employeeData['status'] != 'rejected') {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('Confirm Deletion'),
//                                           content: const Text(
//                                               'Are you sure you want to delete this medical report?'),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () =>
//                                                   Navigator.of(context).pop(),
//                                               child: const Text('Cancel'),
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 deleteMedicalReport(
//                                                     medicalReportId);
//                                               },
//                                               child: const Text('Delete'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   }
//                                 }
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Icon(
//                               Icons.close,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   ListTile(
//                     leading: const Icon(Icons.badge,color: Colors.black,),
//                     title: Text('Employee ID: ${employeeData['employee_id']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.person,color: Colors.black),
//                     title: Text('Employee Name: ${employeeData['employee_name']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.business,color: Colors.black),
//                     title: Text('Department: ${employeeData['department']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.email,color: Colors.black),
//                     title: Text('Email: ${employeeData['email']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.note,color: Colors.black),
//                     title: Text('Reason: ${employeeData['reason']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.assignment,color: Colors.black),
//                     title: Text('Type of Claims: ${employeeData['type_of_claim']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.monetization_on,color: Colors.black),
//                     title: Text('Amount AED: ${employeeData['amount_aed']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.info,color: Colors.black),
//                     title: Text('Status: ${employeeData['status']}'),
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.calendar_today,color: Colors.black),
//                     title: Text('Applied On: ${employeeData['date']}'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _model.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
//           automaticallyImplyLeading: false,
//           leading: FlutterFlowIconButton(
//             borderColor: Colors.transparent,
//             borderRadius: 30,
//             borderWidth: 1,
//             buttonSize: 60,
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.white,
//               size: 30,
//             ),
//             onPressed: () async {
//               context.pop();
//             },
//           ),
//           title: Text(
//             'History of Medical Reports',
//             style: FlutterFlowTheme.of(context).headlineMedium.override(
//                   fontFamily: 'Urbanist',
//                   color: FlutterFlowTheme.of(context).tertiary,
//                 ),
//           ),
//           centerTitle: true,
//           elevation: 2,
//         ),
//         body: SafeArea(
//           child: Column(
//             children: [
//               SingleChildScrollView(
//                 child: PaginatedDataTable(
//                   header: const Text('Medical Reports'),
//                   columns:  [
                    
//                    DataColumn(
//                                 label: DefaultTextStyle.merge(
//                                   softWrap: true,
//                                   child: Text(
//                                     'Employee ID',
//                                     style: FlutterFlowTheme.of(context)
//                                         .labelLarge
//                                         .override(
//                                           fontFamily: 'Readex Pro',
//                                           color: FlutterFlowTheme.of(context)
//                                               .secondaryBackground,
//                                           fontSize: 15,
//                                           letterSpacing: 0,
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                     DataColumn(
//                                 label: DefaultTextStyle.merge(
//                                   softWrap: true,
//                                   child: Text(
//                                     'Status',
//                                     textAlign: TextAlign.start,
//                                     style: FlutterFlowTheme.of(context)
//                                         .labelLarge
//                                         .override(
//                                           fontFamily: 'Readex Pro',
//                                           color: FlutterFlowTheme.of(context)
//                                               .white,
//                                           fontSize: 15,
//                                           letterSpacing: 0,
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                    DataColumn2(
//                                 label: DefaultTextStyle.merge(
//                                   softWrap: true,
//                                   child: Text(
//                                     'Applied On',
//                                     style: FlutterFlowTheme.of(context)
//                                         .labelLarge
//                                         .override(
//                                           fontFamily: 'Readex Pro',
//                                           color: FlutterFlowTheme.of(context)
//                                               .white,
//                                           fontSize: 15,
//                                           letterSpacing: 0,
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                               DataColumn2(
//                                 label: DefaultTextStyle.merge(
//                                   softWrap: true,
//                                   child: Text(
//                                     'More',
//                                     style: FlutterFlowTheme.of(context)
//                                         .labelLarge
//                                         .override(
//                                           fontFamily: 'Readex Pro',
//                                           color: FlutterFlowTheme.of(context)
//                                               .white,
//                                           fontSize: 15,
//                                           letterSpacing: 0,
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                   ],
//                   source: MedicalDataTableSource(
//                     medicalApplications: medicalApplications,
//                     onDelete: (index) {
//                       final medicalReport = medicalApplications[index];
//                       deleteMedicalReport(medicalReport['id']);
//                     },
//                     onTapDetails: (index) {
//                       final medicalReport = medicalApplications[index];
//                       _showEmployeeDetails(medicalReport);
//                     },
//                   ),
//                   onRowsPerPageChanged: (newRowsPerPage) {
//                     setState(() {
//                       rowsPerPage = newRowsPerPage ?? PaginatedDataTable.defaultRowsPerPage;
//                       // Ensure rowsPerPage is greater than 0
//                       rowsPerPage = rowsPerPage > 0 ? rowsPerPage : PaginatedDataTable.defaultRowsPerPage;
//                     });
//                   },
//                   rowsPerPage: rowsPerPage,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MedicalDataTableSource extends DataTableSource {
//   final List<dynamic> medicalApplications;
//   final Function(int) onDelete;
//   final Function(int) onTapDetails;

//   MedicalDataTableSource({
//     required this.medicalApplications,
//     required this.onDelete,
//     required this.onTapDetails,
//   });

//   @override
//   DataRow getRow(int index) {
//     final medicalReport = medicalApplications[index];
//     return DataRow(
//       cells: [
//         DataCell(Text(medicalReport['employee_id'].toString(),
//                                   style: const TextStyle(fontFamily: 'Readex pro')
//                                 ),),
       
      
//         DataCell(Text(
//                                   medicalReport['status'].toString(),
//                                   style: const TextStyle(fontFamily: 'Readex pro')
//                                 ),),
//         DataCell(Text(medicalReport['date'].toString(),
//                                   style: const TextStyle(fontFamily: 'Readex pro')
//                                 ),),
//         DataCell(
//           IconButton(
//             icon: const Icon(
//                                     Icons.keyboard_control_rounded,
//                                     color: Colors.black,
//                                     size: 18,
//                                   ),
//             onPressed: () => onTapDetails(index),
//           ),
//         ),
//       ],
//     );
   
//                             selectable: false,
//                             width: double.infinity,
//                             height: double.infinity,
//                             headingRowHeight: 56,
//                             dataRowHeight: 48,
//                             columnSpacing: 15,
//                             headingRowColor:Color.fromARGB(255, 44, 10, 10),
//                             borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(10),
//                               bottomRight: Radius.circular(10),
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                             );,
//                             addHorizontalDivider: true,
//                             addTopAndBottomDivider: true,
//                             hideDefaultHorizontalDivider: true,
//                             horizontalDividerColor: FlutterFlowTheme.of(context).tigersEye,
//                             horizontalDividerThickness: 0.5,
//                             addVerticalDivider: false,
//   }

//   @override
//   int get rowCount => medicalApplications.length;

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get selectedRowCount => 0;
// }






