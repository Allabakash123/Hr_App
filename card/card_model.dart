import '/flutter_flow/flutter_flow_util.dart';
import 'card_widget.dart' show CardWidget;
import 'package:flutter/material.dart';

class CardModel extends FlutterFlowModel<CardWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
