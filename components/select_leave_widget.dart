// import '/components/apply_form_widget.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'select_leave_model.dart';
// export 'select_leave_model.dart';


// class SelectLeaveWidget extends StatefulWidget {
//   const SelectLeaveWidget({super.key});

//   @override
//   State<SelectLeaveWidget> createState() => _SelectLeaveWidgetState();
// }

// class _SelectLeaveWidgetState extends State<SelectLeaveWidget> {
//   late SelectLeaveModel _model;
//   String? selectedLeaveType;


//   @override
//   void setState(VoidCallback callback) {
//     super.setState(callback);
//     _model.onUpdate();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => SelectLeaveModel());

//     WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
//   }

//   @override
//   void dispose() {
//     _model.maybeDispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 200.0,
//       decoration: BoxDecoration(
//         color: FlutterFlowTheme.of(context).secondaryBackground,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           InkWell(
//             splashColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () async {
//               selectedLeaveType = 'Casual Leave';
//               await showModalBottomSheet(
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 enableDrag: false,
//                 context: context,
//                 builder: (context) {
//                   return Padding(
//                     padding: MediaQuery.viewInsetsOf(context),
//                     child: ApplyFormWidget(selectedLeaveType: selectedLeaveType),
//                   );
//                 },
//               ).then((value) => safeSetState(() {}));
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
//                   child: Icon(
//                     Icons.note_alt,
//                     color: FlutterFlowTheme.of(context).primaryText,
//                     size: 24.0,
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 0.0, 12.0),
//                   child: Text(
//                     'Casual Leave',
//                     style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Readex Pro',
//                           letterSpacing: 0.0,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           InkWell(
//             splashColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () async {
//               selectedLeaveType = 'Sick Leave';
//               await showModalBottomSheet(
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 enableDrag: false,
//                 context: context,
//                 builder: (context) {
//                   return Padding(
//                     padding: MediaQuery.viewInsetsOf(context),
//                     child: const ApplyFormWidget(),
//                   );
//                 },
//               ).then((value) => safeSetState(() {}));
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
//                   child: Icon(
//                     Icons.sick,
//                     color: FlutterFlowTheme.of(context).primaryText,
//                     size: 24.0,
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 0.0, 12.0),
//                   child: Text(
//                     'Sick Leave',
//                     style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Readex Pro',
//                           letterSpacing: 0.0,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           InkWell(
//             splashColor: Colors.transparent,
//             focusColor: Colors.transparent,
//             hoverColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () async {
//               selectedLeaveType = 'Excuse Leave';
//               await showModalBottomSheet(
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 enableDrag: false,
//                 context: context,
//                 builder: (context) {
//                   return Padding(
//                     padding: MediaQuery.viewInsetsOf(context),
//                     child: const ApplyFormWidget(),
//                   );
//                 },
//               ).then((value) => safeSetState(() {}));
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Padding(
//                   padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
//                   child: FaIcon(
//                     FontAwesomeIcons.exchangeAlt,
//                     color: FlutterFlowTheme.of(context).primaryText,
//                     size: 20.0,
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsetsDirectional.fromSTEB(20.0, 15.0, 0.0, 12.0),
//                   child: Text(
//                     'Excuse Leave',
//                     style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Readex Pro',
//                           letterSpacing: 0.0,
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
