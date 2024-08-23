

import 'package:team_c/Business_trip/Business_trip/Business_trip_widget.dart';

import '/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';

class BusinessTripModel
    extends FlutterFlowModel<BusinesstripWidget> {
  ///  State fields for stateful widgets in this page.
  
  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode8;
  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode9;
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode10;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;

  late String empId;
  late String username;
  late String email;
  late String department;

  
  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();

    textFieldFocusNode6?.dispose();
    textController6?.dispose();

    textFieldFocusNode7?.dispose();
    textController7?.dispose();

    textFieldFocusNode8?.dispose();
    textController8?.dispose();

    textFieldFocusNode9?.dispose();
    textController9?.dispose();

    textFieldFocusNode10?.dispose();
    textController10?.dispose();
  }
}

// class BusinessTripSchema {
//   final String empId;
//   final String username;
//   final String department;
//   final String email;
//   final String group;
//   final String employeeName;
//   final String countryTravelTo;
//   final String reason;
//   final double reimbursementAmount;
//   final String travelRequest;
//   final String modeOfPayment;
//   final double amountToBePaidBack;
//   final String effectiveDate;
//   final String comments;
//   final String status;

//   BusinessTripSchema({
//     required this.empId,
//     required this.username,
//     required this.department,
//     required this.email,
//     required this.group,
//     required this.employeeName,
//     required this.countryTravelTo,
//     required this.reason,
//     required this.reimbursementAmount,
//     required this.travelRequest,
//     required this.modeOfPayment,
//     required this.amountToBePaidBack,
//     required this.effectiveDate,
//     required this.comments,
//     required this.status,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'emp_id': empId,
//       'username': username,
//       'department': department,
//       'email': email,
//       'group': group,
//       'employee_name': employeeName,
//       'country_travel_to': countryTravelTo,
//       'reason': reason,
//       'reimbursement_amount': reimbursementAmount,
//       'travel_request': travelRequest,
//       'mode_of_payment': modeOfPayment,
//       'amount_to_be_paid_back': amountToBePaidBack,
//       'effective_date': effectiveDate,
//       'comments': comments,
//       'status': status,
//     };
//   }
// }
