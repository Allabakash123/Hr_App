import '/flutter_flow/flutter_flow_util.dart';
import 'leave_balance_widget.dart' show LeaveBalanceWidget;
import 'package:flutter/material.dart';
class LeaveBalanceModel extends FlutterFlowModel<LeaveBalanceWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PaginatedDataTable widget.
  // final paginatedDataTableController =
  //     FlutterFlowDataTableController<dynamic>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
