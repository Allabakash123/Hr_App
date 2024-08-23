
import '/backend/api_requests/api_calls.dart';
import 'package:flutter/material.dart';

class AttendancePageModel {
  final unfocusNode = FocusNode();
  ApiCallResponse? checkinRes;
  ApiCallResponse? checkoutRes;
  ApiCallResponse? userRes;

  void dispose() {
    unfocusNode.dispose();
  }

  void resetAttendanceState() {
    checkinRes = null;
    checkoutRes = null;
  }
}