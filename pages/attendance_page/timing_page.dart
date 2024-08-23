import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';

class TimeDisplayWidget extends StatefulWidget {
  @override
  _TimeDisplayWidgetState createState() => _TimeDisplayWidgetState();
}

class _TimeDisplayWidgetState extends State<TimeDisplayWidget> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.jm().format(_currentTime),
      style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color:
                                    FlutterFlowTheme.of(context).marianBlue,
                                fontSize: 35.0,
                              ),
    );
  }
}
