import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/UpdatePassword/updateWidget.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_model.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/pages/login/login_widget.dart';
import 'package:team_c/profile_page/edit_image.dart';
import 'package:team_c/profile_page/profile_update/profile_edit_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'profile_page_model.dart';

class ProfilePageWidget extends StatefulWidget {
  final String token;
  const ProfilePageWidget({Key? key,  required this.token}) : super(key: key);

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  late ProfilePageModel _model;
  String? _username;
  String? _empId;
  String? _userImage;
  String? _email;
  String? _department;
  String? _address;
  String? _country;
  String? _state;
  String? _whatsUpNumber;
  String? _dateOfBirth;
  String? _dateJoined;
  String? _phoneNumber;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePageModel());
    fetchUserDetails();
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
 void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginWidget()),
    );
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 20.0,
          ),
           onPressed: () async {
                                  final token = await getAuthToken();
                                  if (token != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EmployepageWidget(token: token)),
                                    );
                                  }
                                },
        ),
        title: Text(
          'Profile',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Outfit',
                color: Colors.white,
                fontSize: 22.0,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 2.0,
      ),
     body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: const Color.fromARGB(255, 221, 220, 220),
                              backgroundImage: _userImage != null
                                  ? MemoryImage(base64Decode(_userImage!))
                                  : null,
                              child: _userImage == null
                                  ? const Icon(Icons.person, size: 55)
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(Icons.camera,size: 25,color: Color.fromARGB(255, 2, 9, 108),),
                                            title: const Text('Camera'),
                                            onTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyCameraWidget(
                                                      username: 'username',
                                                    )),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color.fromARGB(255, 2, 15, 90)
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Color.fromARGB(255, 245, 245, 246),
                                    size: 15.0,
                                    
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader('Profile Info'),
                      _buildProfileRow(Icons.person, 'Employee Name', _username),
                      _buildProfileRow(Icons.badge_outlined, 'Emp Id', _empId),
                      _buildProfileRow(Icons.business, 'Department', _department),
                      _buildProfileRow(Icons.email, 'Email', _email),
                      _buildProfileRow(Icons.calendar_today, 'Date Joined', _dateJoined),
                      const SizedBox(height: 5.0),
                      const Divider(
                        color: Color.fromARGB(255, 116, 115, 115),
                        height: 1.0,
                      ),
                      _buildSectionHeader('Personal Information'),
                      _buildProfileRow(Icons.phone, 'Phone Number', _phoneNumber),
                      _buildProfileRow(Icons.phone_android, 'WhatsApp Number', _whatsUpNumber),
                      _buildProfileRow(Icons.cake, 'Date of Birth', _dateOfBirth),
                      _buildProfileRow(Icons.home, 'Address', _address),
                      _buildProfileRow(Icons.flag, 'Country', _country),
                      const SizedBox(height: 5.0),
                      const Divider(
                        color: Color.fromARGB(255, 116, 115, 115),
                        height: 1.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 15,left: 18),
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            height: 1.5
                          ),
                        ),
                      ),
                      const SizedBox(height: 18.0,),
                      Column(
                        children: [
                          TextButton(onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(builder: (BuildContext context) => const UpdatePasswordWidget(),
                              )
                            );
                            
                          },
                          
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            const Padding(
                                padding:  EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Row(
                                       children: [
                                        Icon(Icons.password,color: Colors.black,size: 15,),
                                         SizedBox(width: 8.0,),
                                          Text(
                                          "Password",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black
                                          ),
                                                                         ),
                                       ],
                                     ),
                                    Row(
                                      children: [
                                        Text(
                                          "Change Password",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue
                                          ),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Icon(Icons.chevron_right_sharp,
                                        color: Colors.black)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                          
                                TextButton(
                        onPressed: _logout,
                          
                        
                        child: const Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 18.0,
                              color: Color.fromARGB(255, 00, 21, 47),
                              
                            ),
                            SizedBox(width: 10.0,),
                              Text(
                              'Logout',
                              style: TextStyle(
                                color: Color.fromARGB(255, 3, 3, 3),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
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
        ]),
      ),
    )));
  }

  
  Widget _buildProfileRow(IconData iconData, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 17.0,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            value ?? '',
            style: TextStyle(
              fontSize: 13,
              color: label == 'Email' ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              // Prepare the profile data to pass
              Map<String, String?> profileData = {
                'phone_number': _phoneNumber,
                'whats_up_number': _whatsUpNumber,
                'address': _address,
                'country': _country,
                'state': _state,
                'date_of_birth': _dateOfBirth,
              };
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileEditWidget(profileData: profileData, token: widget.token,),
              ),
            );
          },
          icon: const Icon(Icons.edit_outlined,
          size: 16.0,
          
          
          ),
        ),
        ],
      ),
    );
  }


  Widget _buildHeader(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
              child: Text(
                label,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Future<void> fetchUserDetails() async {
  
    const String apiUrl = '$apiBaseUrl/hr/api/user_details';
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
    print("Data is fetched");
    final Map<String, dynamic> data = jsonDecode(response.body);
    setState(() {
      _empId = data['emp_id'].toString();
      _username = '${data['first_name']} ${data['last_name']}';
      _userImage = data['user_image']?.toString();
      _email = data['email'].toString();
      _department = data['department'].toString();
      _dateJoined = data['date_joined'].toString();
      _phoneNumber = data['phone_number'].toString();
      _address = data['address'].toString();
      _country = data['country'].toString();
      _state = data['state'].toString();
      _dateOfBirth = data['date_of_birth'].toString();
      _whatsUpNumber = data['whats_up_number'].toString();
     
      
    });
  } else {
    // Handle error
    print('Failed to fetch user details: $response.statusCode');
  }
}
}
