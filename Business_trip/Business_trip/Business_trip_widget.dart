


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:iconsax/iconsax.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:team_c/Business_trip/Business_trip/Business_trip_history.dart';
// import 'package:team_c/auth/custom_auth/auth_util.dart';
// import 'package:team_c/employepage/employepage_widget.dart';
// import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
// import 'package:team_c/flutter_flow/flutter_flow_model.dart';
// import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
// import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
// import 'package:team_c/leaveManagement/leave_management_history_widget.dart';
// import 'package:team_c/utils/const_api.dart';

// import 'Business_trip_widget_model.dart';



// class BusinesstripWidget extends StatefulWidget {
//   final String token;
//   const BusinesstripWidget({
//     Key? key, required this.token, 
  
//   }) : super(key: key);
    
//   @override
//   State<BusinesstripWidget> createState() =>
//       _BusinesstripWidgetState();
// }

// class _BusinesstripWidgetState
//     extends State<BusinesstripWidget> {
//   late BusinessTripModel _model;
//   final scaffoldkey = GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();


// final _employeeNames = [
//   'Abdul Wahed Asad Hassan Abdulla',
//   'Abid Moosa Ali',
//   'Adham Fuddah Hakam Hakam',
//   'Ahammed Noufal Muhammed Kunhi',
//   'Anil Kumar Paliekkara',
//   'Diaa Aldeen Kamel Mohd Sadaqa',
//   'Dileep Purushothaman Sri Kala Purushothaman',
//   'Elshafie Abdelbaset Abdelsalam Mohamed Youssef',
//   'Hardip Singh Gurnam Singh',
//   'Hasen Mohamed Samsudeen',
//   'Isarafil Nadaf',
//   'Jabir Ali',
//   'Jashim Uddin',
//   'Mohammad Shakeer Noor Nayak Mohammad Haneef Noor Nayak',
//   'Sandhya Akella Akella Somappa Somayajulu',
//   'Sumitra Adhikari Ghimire',
//   'Syed Ali Abbas Rizvi Syed Nusrat Ali Rizvi'
// ];
// final _countriesChoices = ['Afghanistan', 'Algeria', 'Bahrain', 'Bangladesh', 'Bhutan', 'Burma Union Myanmar', 'China', 'Djibouti', 'Egypt', 'Hong Kong', 'India', 'Indonesia', 'Iran', 'Iraq', 'Japan', 'Jordan', 'Kampuchea', 'Kuwait', 'Lebanon', 'Libya', 'Malaysia', 'Mauritania', 'Morocco', 'Nepal', 'North Korea', 'Pakistan', 'Palestine', 'Philippines', 'Qatar', 'Saudi Arabia', 'Singapore', 'Somalia', 'South Korea', 'Sri Lanka', 'Sudan', 'Sultanate Of Oman', 'Syria', 'Taiwan', 'Thailand', 'Tunisia', 'United Arab Emirates', 'Vietnam', 'Yemen'];
// final _paymentChoices=['Cash','Salary Deduction',];



//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   final TextEditingController _employeeNameController = TextEditingController();
//   final TextEditingController _employeeIdController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _departmentController = TextEditingController();
  
  
//   bool _isLoading = false;

//   String? _selectedEmployeeName; 
//   String? _selectedCountryName; 
//   String? _selectedPaymentMethod; 

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserDetails();
    
//     _model = createModel(context, () => BusinessTripModel());

//     _model.textController1 ??= TextEditingController();
    
//     _model.textFieldFocusNode1 ??= FocusNode();

//     _model.textController2 ??= TextEditingController();
//     _model.textFieldFocusNode2 ??= FocusNode();

//     _model.textController3 ??= TextEditingController();
//     _model.textFieldFocusNode3 ??= FocusNode();

//     _model.textController4 ??= TextEditingController();
//     _model.textFieldFocusNode4 ??= FocusNode();

//     _model.textController5 ??= TextEditingController();
//     _model.textFieldFocusNode5 ??= FocusNode();

//     _model.textController6 ??= TextEditingController();
//     _model.textFieldFocusNode6 ??= FocusNode();

//     _model.textController7 ??= TextEditingController();
//     _model.textFieldFocusNode7 ??= FocusNode();

//     _model.textController8 ??= TextEditingController();
//     _model.textFieldFocusNode8 ??= FocusNode();

//     _model.textController9 ??= TextEditingController();
//     _model.textFieldFocusNode9 ??= FocusNode();

//      _model.textController10 ??= TextEditingController();
//     _model.textFieldFocusNode10 ??= FocusNode();


    

//     WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
//   }
// @override
//   void dispose() {
//     _model.dispose();
//     super.dispose();
//   }


//    Future<String?> getAuthToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<void> _fetchUserDetails() async {
//     setState(() {
//       _isLoading = true;
//     });
//     final token = await getAuthToken();
//     try {
//       final response = await http.get(
//         Uri.parse('$apiBaseUrl/api/user_details'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         setState(() {
//           _employeeNameController.text = '${data['first_name']} ${data['last_name']}'?? '';
//           _employeeIdController.text = data['Emp_Id'] ?? '';
//           _emailController.text = data['email'] ?? '';
//           _departmentController.text = data['department'] ?? '';
//         });
//       } else {
//         // Handle error response
//         print('Failed to fetch user details: ${response.body}');
//       }
//     } catch (e) {
//       // Handle network or server errors
//       print('Error fetching user details: $e');
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

// Future<void> _sendAdminNotification(String email) async {
//     final response = await http.post(
//       Uri.parse('$apiBaseUrl/api/send_admin_notification'),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'subject': 'Leave Application request',
//         'message': 'Leave Application request by Employee with email $email.',
//         'recipients': ['farhanabadubhai@gmail.com'],
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('Admin notification sent successfully');
//     } else {
//       print('Failed to send admin notification: ${response.body}');
//     }
//   }


// Future<void> _submitLeaveApplication() async {
//   final token = await getAuthToken();
//   // Validate the form fields before proceeding
//   if (_formKey.currentState!.validate()) {
//     try {
//       // Prepare the request body
//       final requestBody = <String, dynamic>{
//         'emp_id': _employeeIdController.text,
//         'username': _employeeNameController.text,
//         'department': _departmentController.text,
//         'email': _emailController.text,
//         'group': _model.textController1?.text,
//         'employee_name': _selectedEmployeeName,
//         'country_travel_to': _selectedCountryName,
//         'reason': _model.textController3?.text,
//         'reimbursement_amount': double.tryParse(_model.textController4!.text) ?? 0.0,
//         'travel_request': _model.textController5?.text,
//         'mode_of_payment': _selectedPaymentMethod,
//         'amount_to_be_paid_back': double.tryParse(_model.textController7!.text) ?? 0.0,
//         'effective_date': _model.textController8?.text,
//         'comments': _model.textController9?.text,
//       };

//       // Print the request body for debugging
//       print('Request Body: $requestBody');

//       // Send the request
//       final response = await http.post(
//         Uri.parse('$apiBaseUrl/api/business-trip'),
//         headers: <String, String>{
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(requestBody),
//       );

//       // Handle the response
//       if (response.statusCode == 200) {
//         // Request successful
//         await _sendAdminNotification(_emailController.text);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Leave request sent successfully'),
//             duration: Duration(seconds: 3),
//             backgroundColor: Colors.green,
//           ),
//         );
//         print('Leave request sent successfully');
//         setState(() {
//           // Clear text fields after successful submission
//           _model.textController1?.clear();
//           _model.textController2?.clear();
//           _model.textController3?.clear();
//           _model.textController4?.clear();
//           _model.textController5?.clear();
//           _model.textController7?.clear();
//           _model.textController8?.clear();
//           _model.textController9?.clear();
//           _selectedEmployeeName = null;
//           _selectedCountryName = null;
//           _selectedPaymentMethod = null;
//         });
//       } else {
//         // Request failed
//         print('Failed to submit leave request: ${response.body}');
//         // Handle error cases
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Failed to submit leave request. Please try again.',
//               style: TextStyle(color: Colors.red),
//             ),
//             duration: const Duration(milliseconds: 4000),
//           ),
//         );
//       }
//     } catch (e) {
//       // Exception occurred
//       print('Exception occurred: $e');
//       // Handle exception cases
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'An error occurred. Please try again later.',
//             style: TextStyle(color: Colors.red),
//           ),
//           duration: const Duration(milliseconds: 4000),
//         ),
//       );
//     }
//   } else {
//     // Display a message if form validation fails
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Please fill all required fields correctly.'),
//         duration: Duration(seconds: 3),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }





//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
//           automaticallyImplyLeading: false,
//           leading: FlutterFlowIconButton(
//             borderColor: Colors.transparent,
//             borderRadius: 30,
//             borderWidth: 1,
//             buttonSize: 40,
//             icon: const Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.white,
//               size: 20,
//             ),
//             onPressed: () async {
//               final token = await getAuthToken();
//               if (token != null) {
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EmployepageWidget(token: token),
//                 ),
//               );
//                 }

//             },
//           ),
//           title: Text(
//             'Business Trip',
//             style: FlutterFlowTheme.of(context).headlineMedium.override(
//                   fontFamily: 'Outfit',
//                   color: Colors.white,
//                   fontSize: 20,
//                   letterSpacing: 0,
//                 ),
//           ),
//           actions: [
//           IconButton(
//             onPressed: (){
              
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BusinessTripHistoryWidget(),
//                   ),
//                 );
              

//             },
//             icon: const Icon(Icons.more_vert),
//             tooltip: 'History',
//           ),
//         ],
//           centerTitle: false,
//           elevation: 2,
//         ),
//         body: SafeArea(
//           top: true,
          
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               color: FlutterFlowTheme.of(context).primaryBackground,
//             ),
//             child: Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Align(
//                       alignment: const AlignmentDirectional(-1, 0),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
//                         child: Text(
//                           'Business Trip-Application',
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline,
//                               ),
//                         ),
//                       ),
//                     ),
//                       // Generated code for this Column Widget...
//                     Align(
//                       alignment: const AlignmentDirectional(-1, 0),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                         child: Text(
//                           'Employee Name',
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0,
//                                 fontSize: 12,
//                                 color: Colors.black
//                               ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                       child: Container(
//                         width: double.infinity,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 4,
//                               color: Color(0x33000000),
//                               offset: Offset(
//                                 0,
//                                 2,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Icon(
//                                 Icons.person,
//                                 color: FlutterFlowTheme.of(context).secondaryText,
//                                 size: 18,
//                               ),
//                             ),
//                             Align(
//                               alignment: const AlignmentDirectional(-1, 0),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                                 child: Text(
//                                   _employeeNameController.text,
//                                   textAlign: TextAlign.start,
//                                   style: FlutterFlowTheme.of(context)
//                                       .bodyMedium
//                                       .override(
//                                          fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                         fontSize: 14
//                                       ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
                  
//                     Align(
//                       alignment: const AlignmentDirectional(-1, 0),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                         child: Text(
//                           'Employee ID',
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0,
//                                 fontSize: 12,
//                                 color: Colors.black
//                               ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                       child: Container(
//                         width: double.infinity,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 4,
//                               color: Color(0x33000000),
//                               offset: Offset(
//                                 0,
//                                 2,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.idBadge,
//                                   color: FlutterFlowTheme.of(context).secondaryText,
//                                   size: 18,
//                                 ),
//                               ),
//                               Align(
//                                 alignment: const AlignmentDirectional(-1, 0),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                                   child: Text(
//                                    _employeeIdController.text,
//                                     textAlign: TextAlign.start,
//                                     style: FlutterFlowTheme.of(context)
//                                         .bodyMedium
//                                         .override(
//                                            fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                         fontSize: 13
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
                    
//                     Align(
//                       alignment: const AlignmentDirectional(-1, 0),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                         child: Text(
//                           'Email Address ',
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0,
//                                 fontSize: 12,
//                                 color: Colors.black
//                               ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                       child: Container(
//                         width: double.infinity,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 4,
//                               color: Color(0x33000000),
//                               offset: Offset(
//                                 0,
//                                 2,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                               child: Icon(
//                                 Icons.email,
//                                 color: FlutterFlowTheme.of(context).secondaryText,
//                                 size: 18,
//                               ),
//                             ),
//                             Align(
//                               alignment: const AlignmentDirectional(-1, 0),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                                 child: Text(
//                                   _emailController.text,
//                                   textAlign: TextAlign.start,
//                                   style: FlutterFlowTheme.of(context)
//                                       .bodyMedium
//                                       .override(
//                                          fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                         fontSize: 13
//                                       ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
                    
                    
//                     Align(
//                       alignment: const AlignmentDirectional(-1, 0),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                         child: Text(
//                           'Business Group ',
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0,
//                                 fontSize: 12,
//                                 color: Colors.black
//                               ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                       child: TextFormField(
//                         controller: _model.textController1,
//                         focusNode: _model.textFieldFocusNode1,
//                         autofocus: true,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           labelStyle:
//                               FlutterFlowTheme.of(context).bodyMedium.override(
//                                     fontFamily: 'Poppins',
//                                     letterSpacing: 0,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                           hintText: 'Business Group ',
//                           hintStyle:
//                               FlutterFlowTheme.of(context).labelMedium.override(
//                                     fontFamily: 'Readex Pro',
//                                     color: FlutterFlowTheme.of(context).primaryText,
//                                     letterSpacing: 0,
//                                     fontSize: 12
                                    
//                                   ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).alternate,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).primaryText,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           errorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           focusedErrorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           filled: true,
//                           fillColor:
//                               FlutterFlowTheme.of(context).secondaryBackground,
//                           prefixIcon:Icon(
//                                     Icons.business_sharp,
//                                     size: 18,
//                                     color: FlutterFlowTheme.of(context).secondaryText,
//                                   ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                               fontFamily: 'Poppins',
//                               color: FlutterFlowTheme.of(context).primaryText,
//                               letterSpacing: 0,
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500
//                             ),
//                         validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Business Group is required';
//                                 }
                                
//                               },
//                         textAlign: TextAlign.start,
                       
//                       ),
//                     ),
                      
//                      Align(
//                       alignment: const AlignmentDirectional(-1, 0),
//                       child: Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                         child: Text(
//                           'Department ',
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 letterSpacing: 0,
//                                 fontSize: 12,
//                                 color: Colors.black
//                               ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                       child: Container(
//                         width: double.infinity,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: FlutterFlowTheme.of(context).secondaryBackground,
//                           boxShadow: const [
//                             BoxShadow(
//                               blurRadius: 4,
//                               color: Color(0x33000000),
//                               offset: Offset(
//                                 0,
//                                 2,
//                               ),
//                             )
//                           ],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                                 child: FaIcon(
//                                   FontAwesomeIcons.briefcase,
//                                   color: FlutterFlowTheme.of(context).secondaryText,
//                                   size: 18,
//                                 ),
//                               ),
//                               Align(
//                                 alignment: const AlignmentDirectional(-1, 0),
//                                 child: Padding(
//                                   padding:
//                                       const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
//                                   child: Text(
//                                      _departmentController.text,
//                                     textAlign: TextAlign.start,
//                                     style: FlutterFlowTheme.of(context)
//                                         .bodyMedium
//                                         .override(
//                                            fontFamily: 'Readex Pro',
//                                         letterSpacing: 0,
//                                         fontSize: 13
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
                  
                  
                  
                    
//                       //employee name
//                       Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
//                         child:Text(
//                         'Employee Name',
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 12.0,
//                           letterSpacing: 0.0,
//                         ),
//                       ),
//                       ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
//                       child: DropdownButtonFormField<String>(
//                         value:  _selectedEmployeeName,
//                                     items: _employeeNames.map(
//                                       (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins',fontSize: 12),), value: e),
//                                     ).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         _selectedEmployeeName = newValue;
//                                       });
//                                     },
//                         decoration: InputDecoration(
//                           hintText: 'Select Employee Name',
//                           hintStyle: FlutterFlowTheme.of(context)
//                               .labelMedium
//                               .override(
//                                 fontFamily: 'Readex Pro',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0.0,
//                               ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).alternate,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).primaryText,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           filled: true,
//                           fillColor: FlutterFlowTheme.of(context).secondaryBackground,
//                           prefixIcon: Icon(
//                             Icons.person,
//                             color: FlutterFlowTheme.of(context).primaryText,
//                             size: 18,
//                           ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Poppins',
//                           color: FlutterFlowTheme.of(context).primaryText,
//                           letterSpacing: 0.0,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500
//                         ),
//                         // textAlign: TextAlign.start,
//                         validator: (value) {
//                           // Add your validation logic here if needed
//                         },
//                       ),
//                     ),
                  
                  
//                       //country travel to
                      
//                     Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
//                         child:Text(
//                         'Country Travel To',
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 12.0,
//                           letterSpacing: 0.0,
//                         ),
//                       ),
//                       ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
//                       child: DropdownButtonFormField<String>(
//                         value:  _selectedCountryName,
//                                     items: _countriesChoices.map(
//                                       (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins',fontSize: 14),), value: e),
//                                     ).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         _selectedCountryName = newValue;
//                                       });
//                                     },
//                         decoration: InputDecoration(
//                           hintText: 'Select Country Travel To',
//                           hintStyle: FlutterFlowTheme.of(context)
//                               .labelMedium
//                               .override(
//                                 fontFamily: 'Readex Pro',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0.0,
//                                 fontSize: 13
//                               ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).alternate,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).primaryText,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           filled: true,
//                           fillColor: FlutterFlowTheme.of(context).secondaryBackground,
//                           prefixIcon:  Icon(
//                               Icons.travel_explore,
//                               size: 18,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                             ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Poppins',
//                           color: FlutterFlowTheme.of(context).primaryText,
//                           letterSpacing: 0.0,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500
//                         ),
//                         // textAlign: TextAlign.start,
//                         validator: (value) {
//                           // Add your validation logic here if needed
//                         },
//                       ),
//                     ),
                  
                      
//                       //Reason
                    
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Text(
//                             'Reason',
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   letterSpacing: 0,
//                                   fontSize: 12
//                                 ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional(1, -1),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                           child: TextFormField(
//                             controller: _model.textController3,
//                             autofocus: true,
//                             obscureText: false,
//                             decoration: InputDecoration(
//                               labelStyle:
//                                   FlutterFlowTheme.of(context).bodyMedium.override(
//                                         fontFamily: 'Poppins',
//                                         letterSpacing: 0,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                               hintText: 'Reason',
//                               hintStyle: FlutterFlowTheme.of(context)
//                                   .labelMedium
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: FlutterFlowTheme.of(context).primaryText,
//                                     letterSpacing: 0,
//                                     fontSize: 13
//                                   ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).alternate,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).primaryText,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               errorBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).error,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               focusedErrorBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).error,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor:
//                                   FlutterFlowTheme.of(context).secondaryBackground,
//                               prefixIcon: Icon(
//                                 Icons.article_rounded,
//                                 size: 18,
//                                 color: FlutterFlowTheme.of(context).secondaryText,
//                               ),
//                             ),
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   color: FlutterFlowTheme.of(context).primaryText,
//                                   letterSpacing: 0,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500
//                                 ),
//                              validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Reason is required';
//                                 }
//                                 return null;
//                               },
//                             textAlign: TextAlign.start,
                            
//                           ),
//                         ),
//                       ),
                  
                  
//                       //Amount To Be Paid BY The Company
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Text(
//                             'Amount To Be Paid BY The Company',
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   letterSpacing: 0,
//                                   fontSize: 12
//                                 ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional(1, -1),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                           child: TextFormField(
//                             controller: _model.textController4,
//                             focusNode: _model.textFieldFocusNode4,
//                             autofocus: true,
//                             obscureText: false,
//                             decoration: InputDecoration(
//                               labelStyle:
//                                   FlutterFlowTheme.of(context).bodyMedium.override(
//                                         fontFamily: 'Poppins',
//                                         letterSpacing: 0,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                               hintText:
//                                   'Amount To Be Paid By The Company',
//                               hintStyle: FlutterFlowTheme.of(context)
//                                   .labelMedium
//                                   .override(
//                                     fontFamily: 'Poppins',
//                                     color: FlutterFlowTheme.of(context).primaryText,
//                                     letterSpacing: 0,
//                                     fontSize: 13
//                                   ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).alternate,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).primaryText,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               errorBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).error,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               focusedErrorBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: FlutterFlowTheme.of(context).error,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor:
//                                   FlutterFlowTheme.of(context).secondaryBackground,
//                               prefixIcon: Icon(
//                                 Icons.money,
//                                 size: 18,
//                                 color: FlutterFlowTheme.of(context).secondaryText,
//                               ),
//                             ),
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   color: FlutterFlowTheme.of(context).primaryText,
//                                   letterSpacing: 0,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w500
//                                 ),
//                                 validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Amount(AED) is required';
//                                 }
//                                 return null;
//                               },
//                             textAlign: TextAlign.start,
                           
//                           ),
//                         ),
//                       ),
                      
//                       //Travel Request Relevent
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Text(
//                             'Travel Request Relevent',
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   letterSpacing: 0,
//                                   fontSize: 12
//                                 ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                         child: TextFormField(
//                           controller: _model.textController5,
//                           focusNode: _model.textFieldFocusNode5,
//                           autofocus: true,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             labelStyle:
//                                 FlutterFlowTheme.of(context).bodyMedium.override(
//                                       fontFamily: 'Poppins',
//                                       letterSpacing: 0,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                             hintText: 'Travel Request Relevent',
//                             hintStyle:
//                                 FlutterFlowTheme.of(context).labelMedium.override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context).primaryText,
//                                       letterSpacing: 0,
//                                       fontSize: 13
//                                     ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).alternate,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedErrorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 FlutterFlowTheme.of(context).secondaryBackground,
//                             prefixIcon: Icon(
//                               Icons.select_all_outlined,
//                               size: 18,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                             ),
//                           ),
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500
//                               ),
//                                validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Travel Request Relevent is required';
//                                 }
//                                 return null;
//                               },
//                           textAlign: TextAlign.start,
                          
//                         ),
//                       ),
                  
//                       //Mode Of Payment
//                       Padding(
//                         padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
//                         child:Text(
//                         'Mode Of Payment',
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 12.0,
//                           letterSpacing: 0.0,
//                         ),
//                       ),
//                       ),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
//                       child: DropdownButtonFormField<String>(
//                         value:  _selectedPaymentMethod,
//                                     items: _paymentChoices.map(
//                                       (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins',fontSize: 14),), value: e),
//                                     ).toList(),
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         _selectedPaymentMethod = newValue;
//                                       });
//                                     },
//                         decoration: InputDecoration(
//                           hintText: 'Select Payment Method',
//                           hintStyle: FlutterFlowTheme.of(context)
//                               .labelMedium
//                               .override(
//                                 fontFamily: 'Poppins',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0.0,
//                                 fontSize: 13
//                               ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).alternate,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).primaryText,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           errorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           focusedErrorBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: FlutterFlowTheme.of(context).error,
//                               width: 1.0,
//                             ),
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           filled: true,
//                           fillColor: FlutterFlowTheme.of(context).secondaryBackground,
//                           prefixIcon:   Icon(
//                               Icons.payment,
//                               size: 18,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                             ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                           fontFamily: 'Poppins',
//                           color: FlutterFlowTheme.of(context).primaryText,
//                           letterSpacing: 0.0,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500
//                         ),
//                         // textAlign: TextAlign.start,
//                         validator: (value) {
//                           // Add your validation logic here if needed
//                         },
//                       ),
//                     ),
                  
                  
                  
                  
                  
//                     //Amount To Be Paid Back To The Company
                  
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Text(
//                             'Amount To Be Paid Back To The Company',
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   letterSpacing: 0,
//                                   fontSize: 12
//                                 ),
//                           ),
//                         ),
//                       ),
                  
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                         child: TextFormField(
//                           controller: _model.textController7,
//                           focusNode: _model.textFieldFocusNode7,
//                           autofocus: true,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             labelStyle:
//                                 FlutterFlowTheme.of(context).bodyMedium.override(
//                                       fontFamily: 'Poppins',
//                                       letterSpacing: 0,
//                                       fontSize: 13
//                                     ),
//                             hintText: 'Amount To Be Paid Back To The Company',
//                             hintStyle:
//                                 FlutterFlowTheme.of(context).labelMedium.override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context).primaryText,
//                                       letterSpacing: 0,
//                                     ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).alternate,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedErrorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 FlutterFlowTheme.of(context).secondaryBackground,
//                             prefixIcon: Icon(
//                               Icons.money,
//                               size: 18,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                             ),
//                           ),
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'If you have balance back to the Company or enter 0';
//                                 }
//                                 return null;
//                               },
//                           textAlign: TextAlign.start,
                         
//                         ),
//                       ),
                      
//                       //effective date
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Text(
//                             'Effective Date  ',
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   letterSpacing: 0,
//                                   fontSize: 12
//                                 ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                         child: TextFormField(
//                           controller: _model.textController8,
//                           focusNode: _model.textFieldFocusNode8,
//                           autofocus: true,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             labelStyle:
//                                 FlutterFlowTheme.of(context).bodyMedium.override(
//                                       fontFamily: 'Poppins',
//                                       letterSpacing: 0,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                             hintText: 'yyyy-mm-dd ',
//                             hintStyle:
//                                 FlutterFlowTheme.of(context).labelMedium.override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context).primaryText,
//                                       letterSpacing: 0,
//                                       fontSize: 13
//                                     ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).alternate,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedErrorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 FlutterFlowTheme.of(context).secondaryBackground,
//                             prefixIcon: Icon(
//                               Icons.calendar_month_sharp,
//                               size: 18,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                             ),
//                           ),
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500
//                               ),
//                                validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'YYYY-mm-dd is required';
//                                 }
//                                 return null;
//                               },
//                           textAlign: TextAlign.start,
                         
//                         ),
//                       ),
                      
//                       //commment
                      
                      
//                       Align(
//                         alignment: AlignmentDirectional(-1, 0),
//                         child: Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Text(
//                             'Comments  ',
//                             style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                   fontFamily: 'Poppins',
//                                   letterSpacing: 0,
//                                   fontSize: 12
//                                 ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
//                         child: TextFormField(
//                           controller: _model.textController9,
//                           focusNode: _model.textFieldFocusNode9,
//                           autofocus: true,
//                           obscureText: false,
//                           decoration: InputDecoration(
//                             labelStyle:
//                                 FlutterFlowTheme.of(context).bodyMedium.override(
//                                       fontFamily: 'Poppins',
//                                       letterSpacing: 0,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                             hintText: 'Comments  ',
//                             hintStyle:
//                                 FlutterFlowTheme.of(context).labelMedium.override(
//                                       fontFamily: 'Poppins',
//                                       color: FlutterFlowTheme.of(context).primaryText,
//                                       letterSpacing: 0,
//                                       fontSize: 13
//                                     ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).alternate,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             errorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             focusedErrorBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: FlutterFlowTheme.of(context).error,
//                                 width: 1,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             filled: true,
//                             fillColor:
//                                 FlutterFlowTheme.of(context).secondaryBackground,
//                             prefixIcon: Icon(
//                               Icons.comment,
//                               size: 18,
//                               color: FlutterFlowTheme.of(context).secondaryText,
//                             ),
//                           ),
//                           style: FlutterFlowTheme.of(context).bodyMedium.override(
//                                 fontFamily: 'Poppins',
//                                 color: FlutterFlowTheme.of(context).primaryText,
//                                 letterSpacing: 0,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Comment is required';
//                                 }
//                                 return null;
//                               },
//                           textAlign: TextAlign.start,
                          
//                         ),
//                       ),
                    
//                       Align(
//                         alignment: const AlignmentDirectional(0, 0),
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
                              
//                               FFButtonWidget(
//                                 onPressed: _submitLeaveApplication,
//                                 text: 'Apply',
//                                 options: FFButtonOptions(
//                                   height: 40,
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       24, 0, 24, 0),
//                                   iconPadding:
//                                       const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
//                                   color: FlutterFlowTheme.of(context).oxfordBlue,
//                                   textStyle: FlutterFlowTheme.of(context)
//                                       .bodyMedium
//                                       .override(
//                                         fontFamily: 'Poppins',
//                                         color: Colors.white,
//                                         letterSpacing: 0,
//                                       ),
//                                   elevation: 3,
//                                   borderSide: const BorderSide(
//                                     color: Colors.transparent,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
                      
                  
                  
//                       ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         ),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/Business_trip/Business_trip/Business_trip_history.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_model.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/leaveManagement/leave_management_history_widget.dart';
import 'package:team_c/utils/const_api.dart';

import 'Business_trip_widget_model.dart';



class BusinesstripWidget extends StatefulWidget {
  final String token;
  const BusinesstripWidget({
    Key? key, required this.token, 
  
  }) : super(key: key);
    
  @override
  State<BusinesstripWidget> createState() =>
      _BusinesstripWidgetState();
}

class _BusinesstripWidgetState
    extends State<BusinesstripWidget> {
  late BusinessTripModel _model;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


final _employeeNames = [
  'Abdul Wahed Asad Hassan Abdulla',
  'Abid Moosa Ali',
  'Adham Fuddah Hakam Hakam',
  'Ahammed Noufal Muhammed Kunhi',
  'Anil Kumar Paliekkara',
  'Diaa Aldeen Kamel Mohd Sadaqa',
  'Dileep Purushothaman Sri Kala Purushothaman',
  'Elshafie Abdelbaset Abdelsalam Mohamed Youssef',
  'Hardip Singh Gurnam Singh',
  'Hasen Mohamed Samsudeen',
  'Isarafil Nadaf',
  'Jabir Ali',
  'Jashim Uddin',
  'Mohammad Shakeer Noor Nayak Mohammad Haneef Noor Nayak',
  'Sandhya Akella Akella Somappa Somayajulu',
  'Sumitra Adhikari Ghimire',
  'Syed Ali Abbas Rizvi Syed Nusrat Ali Rizvi'
];
final _countriesChoices = ['Afghanistan', 'Algeria', 'Bahrain', 'Bangladesh', 'Bhutan', 'Burma Union Myanmar', 'China', 'Djibouti', 'Egypt', 'Hong Kong', 'India', 'Indonesia', 'Iran', 'Iraq', 'Japan', 'Jordan', 'Kampuchea', 'Kuwait', 'Lebanon', 'Libya', 'Malaysia', 'Mauritania', 'Morocco', 'Nepal', 'North Korea', 'Pakistan', 'Palestine', 'Philippines', 'Qatar', 'Saudi Arabia', 'Singapore', 'Somalia', 'South Korea', 'Sri Lanka', 'Sudan', 'Sultanate Of Oman', 'Syria', 'Taiwan', 'Thailand', 'Tunisia', 'United Arab Emirates', 'Vietnam', 'Yemen'];
final _paymentChoices=['Cash','Salary Deduction',];



  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  
  
  bool _isLoading = false;

  String? _selectedEmployeeName; 
  String? _selectedCountryName; 
  String? _selectedPaymentMethod; 

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    
    _model = createModel(context, () => BusinessTripModel());

    _model.textController1 ??= TextEditingController();
    
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController();
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController();
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController();
    _model.textFieldFocusNode7 ??= FocusNode();

    _model.textController8 ??= TextEditingController();
    _model.textFieldFocusNode8 ??= FocusNode();

    _model.textController9 ??= TextEditingController();
    _model.textFieldFocusNode9 ??= FocusNode();

     _model.textController10 ??= TextEditingController();
    _model.textFieldFocusNode10 ??= FocusNode();


    

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }
@override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


   Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _fetchUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    final token = await getAuthToken();
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/hr/api/user_details'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _employeeNameController.text = '${data['first_name']} ${data['last_name']}'?? '';
          _employeeIdController.text = data['emp_id'] ?? '';
          _emailController.text = data['email'] ?? '';
          _departmentController.text = data['department'] ?? '';
        });
      } else {
        // Handle error response
        print('Failed to fetch user details: ${response.body}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error fetching user details: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

Future<void> _sendAdminNotification(String email) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/hr/api/send_admin_notification'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'subject': 'Leave Application request',
        'message': 'Leave Application request by Employee with email $email.',
        'recipients': ['farhanabadubhai@gmail.com'],
      }),
    );

    if (response.statusCode == 200) {
      print('Admin notification sent successfully');
    } else {
      print('Failed to send admin notification: ${response.body}');
    }
  }


Future<void> _submitLeaveApplication() async {
  final token = await getAuthToken();
  // Validate the form fields before proceeding
  if (_formKey.currentState!.validate()) {
    try {
      // Prepare the request body
      final requestBody = <String, dynamic>{
        'emp_id': _employeeIdController.text,
        'username': _employeeNameController.text,
        'department': _departmentController.text,
        'email': _emailController.text,
        'group': _model.textController1?.text,
        'employee_name': _selectedEmployeeName,
        'country_travel_to': _selectedCountryName,
        'businesstrip_reason': _model.textController3?.text,
        'reimbursement_amount': double.tryParse(_model.textController4!.text) ?? 0.0,
        'travel_request': _model.textController5?.text,
        'mode_of_payment': _selectedPaymentMethod,
        'amount_to_be_paid_back': double.tryParse(_model.textController7!.text) ?? 0.0,
        'effective_date': _model.textController8?.text,
        'businessTrip_comments': _model.textController9?.text,
      };

      // Print the request body for debugging
      print('Request Body: $requestBody');

      // Send the request
      final response = await http.post(
        Uri.parse('$apiBaseUrl/hr/api/business-trip'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // Handle the response
      if (response.statusCode == 200) {
        // Request successful
        await _sendAdminNotification(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Leave request sent successfully'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
        print('Leave request sent successfully');
        setState(() {
          // Clear text fields after successful submission
          _model.textController1?.clear();
          _model.textController2?.clear();
          _model.textController3?.clear();
          _model.textController4?.clear();
          _model.textController5?.clear();
          _model.textController7?.clear();
          _model.textController8?.clear();
          _model.textController9?.clear();
          _selectedEmployeeName = null;
          _selectedCountryName = null;
          _selectedPaymentMethod = null;
        });
      } else {
        // Request failed
        print('Failed to submit leave request: ${response.body}');
        // Handle error cases
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to submit leave request. Please try again.',
              style: TextStyle(color: Colors.red),
            ),
            duration: Duration(milliseconds: 4000),
          ),
        );
      }
    } catch (e) {
      // Exception occurred
      print('Exception occurred: $e');
      // Handle exception cases
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(milliseconds: 4000),
        ),
      );
    }
  } else {
    // Display a message if form validation fails
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill all required fields correctly.'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 40,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
              final token = await getAuthToken();
              if (token != null) {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployepageWidget(token: token),
                ),
              );
                }

            },
          ),
          title: Text(
            'Business Trip',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 0,
                ),
          ),
          actions: [
          IconButton(
            onPressed: (){
              
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BusinessTripHistoryWidget(),
                  ),
                );
              

            },
            icon: const Icon(Icons.more_vert),
            tooltip: 'History',
          ),
        ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                        child: Text(
                          'Business Trip-Application',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ),
                    ),
                      // Generated code for this Column Widget...
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Employee Name',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Icon(
                                Icons.person,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  _employeeNameController.text,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Employee Id',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.idBadge,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 18,
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                   _employeeIdController.text,
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Email Address ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                              child: Icon(
                                Icons.email,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  _emailController.text,
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Business Group ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                      child: TextFormField(
                        controller: _model.textController1,
                        focusNode: _model.textFieldFocusNode1,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          hintText: 'Business Group ',
                          hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          prefixIcon:Icon(
                                    Icons.business_sharp,
                                    size: 18,
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                  ),
                        ),
                        style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                        validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Business Group is required';
                                }
                                
                              },
                        textAlign: TextAlign.start,
                       
                      ),
                    ),
                      
                     Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                        child: Text(
                          'Department ',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.briefcase,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 18,
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Text(
                                     _departmentController.text,
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  
                  
                  
                    
                      //employee name
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child:Text(
                        'Employee Name',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value:  _selectedEmployeeName,
                                    items: _employeeNames.map(
                                      (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins',fontSize: 12),), value: e),
                                    ).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedEmployeeName = newValue;
                                      });
                                    },
                        decoration: InputDecoration(
                          hintText: 'Select Employee Name',
                          hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          prefixIcon: Icon(
                            Icons.person,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 18,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                        // textAlign: TextAlign.start,
                        validator: (value) {
                          // Add your validation logic here if needed
                        },
                      ),
                    ),
                  
                  
                      //country travel to
                      
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child:Text(
                        'Country Travel To',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value:  _selectedCountryName,
                                    items: _countriesChoices.map(
                                      (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins',fontSize: 14),), value: e),
                                    ).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCountryName = newValue;
                                      });
                                    },
                        decoration: InputDecoration(
                          hintText: 'Select Country Travel To',
                          hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          prefixIcon:  Icon(
                              Icons.travel_explore,
                              size: 18,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                        ),
                        style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                        // textAlign: TextAlign.start,
                        validator: (value) {
                          // Add your validation logic here if needed
                        },
                      ),
                    ),
                  
                      
                      //Reason
                    
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'BusinessTrip Reason',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 12
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1, -1),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                          child: TextFormField(
                            controller: _model.textController3,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                              hintText: 'Reason',
                              hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                              prefixIcon: Icon(
                                Icons.article_rounded,
                                size: 18,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                             validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Reason is required';
                                }
                                return null;
                              },
                            textAlign: TextAlign.start,
                            
                          ),
                        ),
                      ),
                  
                  
                      //Amount To Be Paid BY The Company
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Amount To Be Paid BY The Company',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 12
                                ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1, -1),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                          child: TextFormField(
                            controller: _model.textController4,
                            focusNode: _model.textFieldFocusNode4,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                      ),
                              hintText:
                                  'Amount To Be Paid By The Company',
                              hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                              prefixIcon: Icon(
                                Icons.money,
                                size: 18,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                            style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Amount(AED) is required';
                                }
                                return null;
                              },
                            textAlign: TextAlign.start,
                           
                          ),
                        ),
                      ),
                      
                      //Travel Request Relevent
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Travel Request Relevent',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 12
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                        child: TextFormField(
                          controller: _model.textController5,
                          focusNode: _model.textFieldFocusNode5,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                            hintText: 'Travel Request Relevent',
                            hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            prefixIcon: Icon(
                              Icons.select_all_outlined,
                              size: 18,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                               validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Travel Request Relevent is required';
                                }
                                return null;
                              },
                          textAlign: TextAlign.start,
                          
                        ),
                      ),
                  
                      //Mode Of Payment
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child:Text(
                        'Mode Of Payment',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                        ),
                      ),
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value:  _selectedPaymentMethod,
                                    items: _paymentChoices.map(
                                      (e) => DropdownMenuItem(child: Text(e,style: const TextStyle(fontFamily: 'Poppins',fontSize: 14),), value: e),
                                    ).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedPaymentMethod = newValue;
                                      });
                                    },
                        decoration: InputDecoration(
                          hintText: 'Select Payment Method',
                          hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                          prefixIcon:   Icon(
                              Icons.payment,
                              size: 18,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                        ),
                        style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                        // textAlign: TextAlign.start,
                        validator: (value) {
                          // Add your validation logic here if needed
                        },
                      ),
                    ),
                  
                  
                  
                  
                  
                    //Amount To Be Paid Back To The Company
                  
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Amount To Be Paid Back To The Company',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 12
                                ),
                          ),
                        ),
                      ),
                  
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                        child: TextFormField(
                          controller: _model.textController7,
                          focusNode: _model.textFieldFocusNode7,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0,
                                      fontSize: 13
                                    ),
                            hintText: 'Amount To Be Paid Back To The Company',
                            hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            prefixIcon: Icon(
                              Icons.money,
                              size: 18,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'If you have balance back to the Company or enter 0';
                                }
                                return null;
                              },
                          textAlign: TextAlign.start,
                         
                        ),
                      ),
                      
                      //effective date
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Effective Date',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 12
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                        child: TextFormField(
                          controller: _model.textController8,
                          focusNode: _model.textFieldFocusNode8,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                            hintText: 'yyyy-mm-dd ',
                            hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            prefixIcon: Icon(
                              Icons.calendar_month_sharp,
                              size: 18,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                               validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Effective Date is required';
                                }
                                return null;
                              },
                          textAlign: TextAlign.start,
                         
                        ),
                      ),
                      
                      //commment
                      
                      
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Comment',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontSize: 12
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 12, 0),
                        child: TextFormField(
                          controller: _model.textController9,
                          focusNode: _model.textFieldFocusNode9,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle:
                                FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                            hintText: 'Comment',
                            hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            prefixIcon: Icon(
                              Icons.comment,
                              size: 18,
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Comment is required';
                                }
                                return null;
                              },
                          textAlign: TextAlign.start,
                          
                        ),
                      ),
                    
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              FFButtonWidget(
                                onPressed: _submitLeaveApplication,
                                text: 'Apply',
                                options: FFButtonOptions(
                                  height: 40,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      24, 0, 24, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).oxfordBlue,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        letterSpacing: 0,
                                      ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ), loadingIndicatorColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                  
                  
                      ],
                  ),
                ),
              ),
            ),
          ),
        ),
        ),
    );
  }
}