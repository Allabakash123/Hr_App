import 'package:team_c/pages/login/face_login.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';

import 'package:flutter/material.dart';

class LoginFaceModel extends FlutterFlowModel<FaceLogin> {
  ///  Local state fields for this page.

  DateTime? timecheck;

  DateTime? checkinTime;

  DateTime? checkoutTime;


  final unfocusNode = FocusNode();
 
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  
  ApiCallResponse? apiloginface;



  @override
  void initState(BuildContext context) {
    // passwordVisibility = false;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}



