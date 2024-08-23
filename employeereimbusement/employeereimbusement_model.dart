// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class EmployeeReimbursementModel extends ChangeNotifier {
//   late FocusNode unfocusNode;

//   // Example properties for reimbursement management
//   String employeeName = '';
//   String employeeID = '';
//   String emailAddress = '';
//   String businessGroup = '';
//   String department = '';
//   String expenseTyp = '';
//   double amountRequested = 0.0;
//   DateTime? expenseDate;
//   String expenseDescription = '';
//   String comments = '';

//   EmployeeReimbursementModel() {
//     unfocusNode = FocusNode();
//   }

//   // Method to dispose the focus node
//   void dispose() {
//     unfocusNode.dispose();
//     super.dispose();
//   }

//   // Method to update the employee name
//   void updateEmployeeName(String name) {
//     employeeName = name;
//     notifyListeners();
//   }

//   // Add similar update methods for other properties as needed

//   // Method to submit reimbursement request
//   void submitReimbursementRequest() {
//     // Add your logic here to submit the reimbursement request
//     // For example, you can send the data to an API or save it locally
//     // You can also perform validation checks before submitting the request
//   }
// }


import 'package:team_c/employeereimbusement/employeereimbusement_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class EmployeeReimbursementModel extends FlutterFlowModel<EmployeeReimbursementWidget> {
  final unfocusNode = FocusNode();
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;

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
  }
}
