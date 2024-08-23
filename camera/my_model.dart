import 'package:flutter/material.dart';

class MyModel {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late FocusNode textFieldFocusNode1;
  late FocusNode textFieldFocusNode2;
  bool passwordVisibility = false;

  MyModel() {
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textFieldFocusNode1 = FocusNode();
    textFieldFocusNode2 = FocusNode();
  }

  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textFieldFocusNode1.dispose();
    textFieldFocusNode2.dispose();
  }
}
