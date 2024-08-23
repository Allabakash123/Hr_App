import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/employepage/employepage_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'attendencereport_model.dart';
export 'attendencereport_model.dart';

class AttendencereportWidget extends StatefulWidget {
  const AttendencereportWidget({super.key});

  @override
  State<AttendencereportWidget> createState() => _AttendencereportWidgetState();
}

class _AttendencereportWidgetState extends State<AttendencereportWidget> {
  late AttendencereportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AttendencereportModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }


Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  
  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,

                onTap: () async {
                  final token = await getAuthToken();
                  if (token != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployepageWidget(token: token)),
                    );
                  }
                },
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: FlutterFlowTheme.of(context).error,
                  size: 35.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
