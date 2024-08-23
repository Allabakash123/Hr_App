import '/flutter_flow/flutter_flow_util.dart';
import 'calender_widget.dart' show CalenderWidget;
import 'package:flutter/material.dart';

class CalenderModel extends FlutterFlowModel<CalenderWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
