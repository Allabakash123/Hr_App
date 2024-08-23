// ignore_for_file: prefer_const_constructors, unnecessary_const, prefer_const_literals_to_create_immutables, unused_import, unnecessary_import, use_super_parameters, prefer_final_fields, unused_field, avoid_print, use_build_context_synchronously, prefer_const_declarations
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/BankDetails/Bank_details_Widget.dart';
import 'package:team_c/BankDetails/Bank_details_history.dart';
import 'package:team_c/Business_trip/Business_trip/Business_trip_history.dart';
import 'package:team_c/Business_trip/Business_trip/Business_trip_widget.dart';
import 'package:team_c/Employeetravel/Employeetravelhistory.dart';
import 'package:team_c/Employeetravel/Employeetravelwidget.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_detail.dart';
import 'package:team_c/Labour_contract/labour_contract_amendment_reque_widget.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/backend/api_requests/api_calls.dart';
import 'package:team_c/card/card_widget.dart';
import 'package:team_c/document_record/labour_card/labour-card_widget.dart';
import 'package:team_c/document_record/passport/passport_widget.dart';
import 'package:team_c/document_record/visa_widget.dart';
import 'package:team_c/emp_resumption/empresumption_widget.dart';
import 'package:team_c/emp_resumption/history_resumption_widget.dart';
import 'package:team_c/employee_exception/employee_exception_widget.dart';
import 'package:team_c/employee_exception/exception_history.dart';
import 'package:team_c/employeereimbusement/employeereimbusement_widget.dart';
import 'package:team_c/employepage/employepage_model.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_util.dart';
import 'package:team_c/historybalance/historybalance_widget.dart';
import 'package:team_c/leaveManagement/leave_balance_widget.dart';
import 'package:team_c/leaveManagement/leave_management_history_widget.dart';
import 'package:team_c/leaveManagement/leave_managment_widget.dart';
import 'package:team_c/medicalReport/medical_report_widget.dart';
import 'package:team_c/pages/attendance_page/attendance_page_widget.dart';
import 'package:team_c/pages/attendance_page/bottomnav.dart';
import 'package:team_c/pages/login/login_widget.dart';
import 'package:team_c/profile_page/profile_page_widget.dart';
import 'package:team_c/profile_page/profile_update/profile_edit_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/helpers/helper_function.dart';
import 'package:team_c/visiting_card/visiting_Form.dart';
import 'package:team_c/visiting_card/visting_card.dart';
import '../medicalReport/history_balance_copy_widget.dart';


class EmployepageWidget extends StatefulWidget {
  final String token;
  const EmployepageWidget({Key? key,required this.token}) : super(key: key);

  @override
  State<EmployepageWidget> createState() => _EmployepageWidgetState();
}

class _EmployepageWidgetState extends State<EmployepageWidget> {
  late FlutterTts flutterTts;
   late EmployepageModel _model;
  String? _username;
  bool _isMenuOpen = false;
  bool _isRequestsOpen = false;
  bool _isLeaveManagementOpen = false;

    final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
    flutterTts = FlutterTts();
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _speak(String message) async {
    await flutterTts.setLanguage('en-US'); // Set to English (US)
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(100.0);
    await flutterTts.setPitch(100.0);
    await flutterTts.speak(message);
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWidget()),
    );
    
  }



  Future<void> fetchUserDetails() async {
   
    final String apiUrl = '$apiBaseUrl/hr/api/user_details';
    print('Fetching user details with token: ${widget.token}');
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        
        'Authorization': 'Bearer ${widget.token}',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _username = data['username'];
      });
      
      print('Username: $_username');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch user details')),
      );
    }
  }

//   Future<bool> _checkIfDataExists() async {
    
//  final token = await getAuthToken();
  
  
//   final String? jwt3 = token;
//     final String apiUrl = '$apiBaseUrl/hr/api/visiting-card-get';
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $jwt3',
//       },
//     );

//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return data.isNotEmpty;
//     } else if (response.statusCode == 404) {
//       return false;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }


Future<bool> _checkIfDataExists() async {
  final token = await getAuthToken();
  final String? jwt3 = token;
  final String apiUrl = '$apiBaseUrl/hr/api/visiting-card-get';
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    },
  );

  if (response.statusCode == 200) {
    // Decode the response as a Map instead of a List
    Map<String, dynamic> data = json.decode(response.body);
    
    // You can check if the map contains expected keys or values
    if (data.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('You already have a Card'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
      });
    }

    // Return true if data is not empty, which indicates that the card exists
    return data.isNotEmpty;
  } else if (response.statusCode == 404) {
    return false;
  } else {
    throw Exception('Failed to load data');
  }
}
void _showDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Stack(
          children: [
            const Text('Select an option'),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<bool>(
              future: _checkIfDataExists(),
              builder: (context, snapshot) {
                bool dataExists = snapshot.data ?? false;
                return ListTile(
                  leading: const Icon(Icons.add_circle_outline, color: Colors.black),
                  title: Text(
                    'Create Visiting Card',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: 0,
                      fontSize: 14,
                      color: dataExists ? Colors.red : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                
                  onTap: () async {
                    final token = await getAuthToken();
                  bool dataExists = await _checkIfDataExists();
                  if (!dataExists) {
                   if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => VistingCardFormWidget(token: token)),
                                    );
                                  }
                  } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Card already exists. Cannot create a new visiting card.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye, color: Colors.black),
              title: const Text(
                'View Visiting Card',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  letterSpacing: 0,
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardviisitWidget()),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}


  // void _showDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Stack(
  //           children: [
  //             const Text('Select an option'),
  //             Positioned(
  //               right: 0.0,
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Icon(
  //                   Icons.close,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.add_circle_outline, color: Colors.black),
  //               title: const Text(
  //                 'Create Visiting Card',
  //                 style: TextStyle(
  //                   fontFamily: 'Poppins',
  //                   letterSpacing: 0,
  //                   fontSize: 14,
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               onTap: () async {
  //                  final token = await getAuthToken();
  //                 bool dataExists = await _checkIfDataExists();
  //                 if (!dataExists) {
  //                  if (token != null) {
  //                                   // Navigator.push(
  //                                   //   context,
  //                                   //   MaterialPageRoute(builder: (context) => VistingCardFormWidget(token: token)),
  //                                   // );
  //                                 }
  //                 } else {
                    
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     const SnackBar(content: Text('Card already exists. Cannot create a new visiting card.'), backgroundColor: Colors.red,),
  //                   );
  //                 }
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.remove_red_eye, color: Colors.black),
  //               title: const Text(
  //                 'View Visiting Card',
  //                 style: TextStyle(
  //                   fontFamily: 'Poppins',
  //                   letterSpacing: 0,
  //                   fontSize: 14,
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) =>  CardviisitWidget()),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 24),
              onPressed: () {
                 scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
           
          actions: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap:   _logout,
            child: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: FlutterFlowTheme.of(context).white,
                    size: 20.0,
                  ),
                  const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12), // Add some padding to the right if needed
        ],
          
        //   actions: [
        //      Align(
        //         alignment: AlignmentDirectional(0, 0),
        //         child: ElevatedButton(
        //           onPressed: _logout,
        //           child: const Text(
        //             'Logout',
        //             style: TextStyle(
        //               fontFamily: 'Readex Pro',
        //               fontSize: 25,
        //               letterSpacing: 0,
        //             ),
        //           ),
        //         ),
        //       ),
        //   const SizedBox(width: 12), // Add some padding to the right if needed
        // ],
        flexibleSpace: FlexibleSpaceBar(
          title: Align(
            alignment: const AlignmentDirectional(1.0, 0.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
            ),
          ),
          centerTitle: true,
          expandedTitleScale: 1.0,
        ),
          elevation: 2.0,
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                // width:THelperFunctions.screenWidth()*1.0,
                // height: THelperFunctions.screenHeight()*0.2,
                 color: FlutterFlowTheme.of(context).oxfordBlue,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome $_username',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
                Column(
                  children: [
                  
                  //leave
                  
                  ListTile(
                      title: const Row(
                        children: [
                          Icon(
                            Icons.work, // Application icon
                            color: Color.fromARGB(255, 161, 220, 78),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Leave Management',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13
                              
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      onTap: () {
                        // No need for onTap since we're using PopupMenuButton
                      },
                      trailing: PopupMenuButton<String>(
                        icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                        onSelected: (value) async {
                               final token = await getAuthToken();
                          // Handle option selection here
                          switch (value) {
                            case 'Leave Application':
                              if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LeaveWidget(token: token)),
                                    );
                                  }
                              break;
                              case 'Leave History':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LeaveManagementHistoryWidget()),
                              );
                              break;
                              case 'Leave Balance':
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LeaveBalanceWidget()),
                              );
                              break;
                            // Handle other options similarly
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'Leave Application',
                            child: ListTile(
                              leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                              title: Text(
                                'Leave Application',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'Leave History',
                            child: ListTile(
                              leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                              title: Text(
                                'Leave History',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'Leave Balance',
                            child: ListTile(
                              leading: Icon(Icons.account_balance_wallet,
                                  color: Color.fromARGB(255, 214, 65, 234)),
                              title: Text(
                                'Leave Balance',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                   // document dropdown
                  ListTile(
                          title: const Row(
                            children: [
                                const Icon(Icons.description, color: Color.fromARGB(255, 106, 106, 242)), // Application icon
                              SizedBox(width: 10),
                              Text(
                                'Documents Of Records',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13
                                ),
                                overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                              ),
                            ],
                          ),
                          trailing: PopupMenuButton<String>(
                            icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                            onSelected: (value)async {
                               final token = await getAuthToken();
                              // Handle option selection here
                              switch (value) {
                                case 'Create document record for visa':
                                  // Navigate to Document record for visa  Page
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateRecordForVisaWidget(token: token)),
                                    );
                                  }
                                  break;
                                case 'Create document record for Passport':
                                  // Navigate to Document for passport Page
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateRecordForPassportWidget(token: token)),
                                    );
                                  }
                                  break;
                                 case 'Create document record for Labour card':
                                  // Navigate to document for Labour cardPage
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateLabourCardWidget(token:token,)),
                                    );
                                  }
                                  break;

                                // Handle other options similarly
                              }
                            },


                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'Create document record for visa',
                                child: ListTile(
                                  leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                  title: Text(
                                    'Create document record for Visa',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,

                                    ),
                                    overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                                  ),
                                ),
                              ),

                              const PopupMenuItem(
                                value: 'Create document record for Passport',
                                child: ListTile(
                                  leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                  title: Text(
                                    'Create document record for Passport',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                                  ),
                                ),
                              ),

                              const PopupMenuItem(
                                value: 'Create document record for Labour card',
                                child: ListTile(
                                  leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                  title: Text(
                                    'Create document record for Labour card',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ),
                    
                    //labour dd
                  ListTile(
                        title: const Row(
                          children: [
                            Icon(
                              Icons.person, // Application icon
                              color: Color.fromARGB(255, 4, 4, 4),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Labour Contract Application',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                              ),
                              overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                          onSelected: (value) async{
                             final token = await getAuthToken();
  
                            // Handle option selection here
                            switch (value) {
                              case 'Labour Contract Application':
                                // Navigate to Labour Contract Page
                                                              if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LabourContractAmendmentRequeWidget(token: token)),
                                    );
                                  }

                                break;
                              case 'Labour Contract History':
                                // Navigate to Labour History Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LabourHistoryBalanceCopyWidget(),
                                  ),
                                );
                                break;
                              // Handle other options similarly
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'Labour Contract Application',
                              child: ListTile(
                                leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                title: Text(
                                  'Labour Contract Application',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'Labour Contract History',
                              child: ListTile(
                                leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                                title: Text(
                                  'Labour Contract History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                  //Medical

                  ListTile(
                      title: const Row(
                        children: [
                          Icon(
                            Icons.local_hospital, color: Color.fromARGB(255, 241, 11, 11),size: 18,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                          child: Text(
                            'Medical Reimbursement Request',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            maxLines: 1, // Limit to a single line
                            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                          ),
                        ),
                        ],
                      ),
                      onTap: () {
                        // No need for onTap since we're using PopupMenuButton
                      },
                      trailing: PopupMenuButton<String>(
                        icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                        onSelected: (value) async {
                           final token = await getAuthToken();
                          // Handle option selection here
                          switch (value) {
                            case 'Medical Reimbursement Application':
                                if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MedicalReportWidget(token: widget.token)),
                                    );
                                  }
                              break;
                            // Handle other options similarly
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'Medical Reimbursement Application',
                            child: ListTile(
                              leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                              title: Text(
                                'Medical Reimbursement Application',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Medical Reimbursement History',
                            child: const ListTile(
                              leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                              title: Text(
                                'Medical Reimbursement History',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HistoryBalanceCopyWidget(),
                                ),
                              );
                            },
                          ),

                          
                        ],
                      ),
                    ),
                  
                  //busineess trip


                  ListTile(
                        title: const Row(
                          children: [
                            Icon(
                              Icons.business, color: Color.fromARGB(255, 3, 77, 88)),
                            SizedBox(width: 10),
                            Text(
                              'Business Trip Application',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                              ),
                              overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                        icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                          onSelected: (value)async {
                             final token = await getAuthToken();
                            // Handle option selection here
                            switch (value) {
                              case 'Business Trip Application':
                                // Navigate to Labour Contract Page
                                 if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BusinesstripWidget(token: token)),
                                    );
                                  }
                                break;
                              case 'Business Trip History':
                                // Navigate to Labour History Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  BusinessTripHistoryWidget(),
                                  ),
                                );
                                break;
                              // Handle other options similarly
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'Business Trip Application',
                              child: ListTile(
                                leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                title: Text(
                                  'Business Trip Application',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'Business Trip History',
                              child: ListTile(
                                leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                                title: Text(
                                  'Business Trip History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  //Employee Reimbursement
                  ListTile(
                      title: const Row(
                        children: [
                          Icon(Icons.attach_money, color: Color.fromARGB(255, 19, 235, 8),size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                          child: Text(
                            'Employee Reimbursement',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                            maxLines: 1, // Limit to a single line
                            overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                          ),
                        ),
                        ],
                      ),
                      onTap: () {
                        // No need for onTap since we're using PopupMenuButton
                      },
                      trailing: PopupMenuButton<String>(
                        icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                        onSelected: (value) async {
                           final token = await getAuthToken();
                          // Handle option selection here
                          switch (value) {
                            case 'Employee Reimbursement Application':
                              if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EmployeeReimbursementWidget(token: token)),
                                    );
                                  }

                              break;
                            // Handle other options similarly
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'Employee Reimbursement Application',
                            child: ListTile(
                              leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                              title: Text(
                                'Employee Reimbursement Application',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Employee Reimbursement History',
                            child: const ListTile(
                              leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                              title: Text(
                                'Employee Reimbursement History',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmployeeHistoryBalanceCopyWidget(),
                                ),
                              );
                            },
                          ),

                          
                        ],
                      ),
                    ),
                  
                  
                  //bank details
                  //bank details
                    ListTile(
                      title: const Row(
                        children: [
                          Icon(
                            Icons.account_balance, // Application icon
                            color: Color.fromARGB(255, 4, 42, 131),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Submit New Bank Account Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                              ),
                              overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: 20.0,
                          ),
                        ),
                        onSelected: (value) async {
                           final token = await getAuthToken();
                          switch (value) {
                            case 'Bank Account Details Application':
                              await _speak(
                                  'Welcome to the Bank Account Details Application Page');
                              if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BankDetailsCopyWidget(token: token)),
                                    );
                                  }
                              break;
                            case 'Bank Account Details History':
                              await _speak(
                                  'Welcome to the Bank Account Details History Page');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BankDetailsHistoryWidget(),
                                ),
                              );
                              break;
                            // Handle other options similarly
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            value: 'Bank Account Details Application',
                            child: ListTile(
                              leading: Icon(Icons.file_copy,
                                  color: Color.fromARGB(255, 58, 105, 223)),
                              title: Text(
                                'Bank Account Details Application',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'Bank Account Details History',
                            child: ListTile(
                              leading: Icon(Icons.history,
                                  color: Color.fromARGB(255, 96, 237, 65)),
                              title: Text(
                                'Bank Account Details History',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                  
                  //Employee resumption
                  ListTile(
                        title: const Row(
                          children: [
                            Icon(
                              Iconsax.repeat_circle, // Application icon
                              color: Color.fromARGB(255, 4, 4, 4),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Employee Resumption Reoprt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13
                                ),
                                overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                          onSelected: (value) {
                            // Handle option selection here
                            switch (value) {
                              case 'Employee Resumption Application':
                                // Navigate to Labour Contract Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EmployeeResumptionWidget(),
                                  ),
                                );
                                break;
                              case 'Employee Resumption History':
                                // Navigate to Labour History Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EmployeeResumption(),
                                  ),
                                );
                                break;
                              // Handle other options similarly
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'Employee Resumption Application',
                              child: ListTile(
                                leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                title: Text(
                                  'Employee Resumption Application',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'Employee Resumption History',
                              child: ListTile(
                                leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                                title: Text(
                                  'Employee Resumption History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  //travel
                  ListTile(
                        title: const Row(
                          children: [
                            Icon(
                              Iconsax.airplane, // Application icon
                              color: Color.fromARGB(255, 109, 78, 78),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Travel Request',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13
                              ),
                              overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                          onSelected: (value) async{
                             final token = await getAuthToken();
                            // Handle option selection here
                            switch (value) {
                              case 'Travel Request Application':
                                // Navigate to Labour Contract Page
                                                              if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TravelWidget(token: token)),
                                    );
                                  }
                                break;
                              case 'Travel Request History':
                                // Navigate to Labour History Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SubmitTravelHistoryWidget(),
                                  ),
                                );
                                break;
                              // Handle other options similarly
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'Travel Request Application',
                              child: ListTile(
                                leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                title: Text(
                                  'Travel Request Application',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'Travel Request History',
                              child: ListTile(
                                leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                                title: Text(
                                  'Travel Request History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  

                  //attendance exception
                  
                  ListTile(
                        title: const Row(
                          children: [
                            Icon(
                              Iconsax.timer_11, // Application icon
                              color: Color.fromARGB(255, 4, 4, 4),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Employee Attendance Exception',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13
                                ),
                                overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Colors.black,
                                
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                              size: 20.0,
                            ),
                          ),
                          onSelected: (value) async{
                             final token = await getAuthToken();
                            // Handle option selection here
                            switch (value) {
                              case 'Employee Attendance Exception Application':
                                // Navigate to Labour Contract Page
                                 if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EmployeeExceptionWidget(token: widget.token)),
                                    );
                                  }
                                break;
                              case 'Employee Attendance Exception History':
                                // Navigate to Labour History Page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EmployeeExceptionHistory(),
                                  ),
                                );
                                break;
                              // Handle other options similarly
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'Employee Attendance Exception Application',
                              child: ListTile(
                                leading: Icon(Icons.file_copy, color: Color.fromARGB(255, 58, 105, 223)),
                                title: Text(
                                  'Employee Attendance Exception Application',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'Employee Attendance Exception History',
                              child: ListTile(
                                leading: Icon(Icons.history, color: Color.fromARGB(255, 96, 237, 65)),
                                title: Text(
                                  'Employee Attendance Exception History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),  
                  ],
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: 844.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.apiResultdvx = await LoginCall.call();
                if (!(_model.apiResultdvx?.succeeded ?? true)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'not fetch the name',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: const Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                }

                setState(() {});
              },
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        12.0, 0.0, 0.0, 12.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome ',
                            style: TextStyle(
                              fontSize: 20,
                              color: FlutterFlowTheme.of(context).orangeWeb,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: _username ??
                                '', // Display fetched username or 'Loading...' if not available yet
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 18.0,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          10.0, 0.0, 10.0, 0.0),
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 2.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            width: 100.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).lightCyan,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).pacificCyan,
                              ),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                             onTap: () async {
                                  final token = await getAuthToken();
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => AttendancePageWidget(token: token)),
                                    );
                                  }
                                },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 5.0),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .nonPhotoBlue,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                          topLeft: Radius.circular(40.0),
                                          topRight: Radius.circular(40.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person_remove_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Attendance',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBECAE),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).orangeWeb,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 5.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).warning,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(40.0),
                                        bottomRight: Radius.circular(40.0),
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Icon(
                                      FFIcons.kpersonPinCircle,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Check In Meeting',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).salmonPink,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).blush,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 5.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).blush,
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(40.0),
                                        bottomRight: Radius.circular(40.0),
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Icon(
                                      FFIcons.klibraryBooks,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Timesheet',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4E1EC),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: const Color(0xFFCCACEE),
                              ),
                            ),
                            child: InkWell(
                              
                              onTap: () async{
                                 final token = await getAuthToken();

                                if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BankDetailsCopyWidget(token: token)),
                                    );
                                  }
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 5.0),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFC4BEC7),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(40.0),
                                          bottomRight: Radius.circular(40.0),
                                          topLeft: Radius.circular(40.0),
                                          topRight: Radius.circular(40.0),
                                        ),
                                      ),
                                      child: Icon(
                                        FFIcons.kcardTravel,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Leave Applications',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEED0D0),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).salmonPink,
                              ),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => const ProfilePageWidget()),
                                // );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 5.0),
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: const BoxDecoration(
                                      color: Color(0xFFD9A9A9),
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(40.0),
                                            bottomRight: Radius.circular(40.0),
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                        ),
                                        child: Icon(
                                      FFIcons.kcolumns1,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'HR Policy',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tigersEye,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).orangePantone,
                              ),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                  final token = await getAuthToken();
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProfilePageWidget(token: token)),
                                    );
                                  }
                                },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 5.0),
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .earthYellow,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(40.0),
                                            bottomRight: Radius.circular(40.0),
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.person_outlined,
                                          color: Colors.black,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'My Profile ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E9AD),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).saffron,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 5.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                      color: Color(0xBAECDD7F),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(40.0),
                                        bottomRight: Radius.circular(40.0),
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Icon(
                                      FFIcons.klibraryBooks,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Attendance Report',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFFC3BDF1),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color: const Color(0xFF8F76E3),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 5.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE2CCE3),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(40.0),
                                        bottomRight: Radius.circular(40.0),
                                        topLeft: Radius.circular(40.0),
                                        topRight: Radius.circular(40.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person_add_alt,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Employee Referral',
                                  style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                       
                           GestureDetector(
                            onTap:_showDialog ,
                             child: Container(
                                 width: 0,
                                height: 113,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9F9F9F),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).oxfordBlue,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 5),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        child: Icon(
                                          Icons.credit_card,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Visiting Card',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                           
                           ),
                            Container(
                            width: 0.0,
                            height: 113.0,
                            decoration: BoxDecoration(
                               color: Color(0xFFF0CE9F),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).orangePantone,
                              ),
                            ),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const CardWidget()),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        const AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 12.0, 0.0, 5.0),
                                      child: Container(
                                        width: 50.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                            .tertiary,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(40.0),
                                            bottomRight: Radius.circular(40.0),
                                            topLeft: Radius.circular(40.0),
                                            topRight: Radius.circular(40.0),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.badge_outlined,
                                          color: Colors.black,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'ID Card ',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
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
      bottomNavigationBar: BottomNavBar(currentIndex:0)
    );
  }
}
