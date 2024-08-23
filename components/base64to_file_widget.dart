



import 'dart:convert';
import 'dart:typed_data';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:team_c/components/popupmessageWidget.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_util.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/pages/login/login_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:team_c/utils/const_api.dart';

class Base64toFileWidget extends StatefulWidget {
  final Uint8List? base64ImageBytes;
  final VoidCallback? onReturn;

  const Base64toFileWidget({
    Key? key,
    required this.base64ImageBytes,
    this.onReturn,
  }) : super(key: key);

  @override
  _Base64toFileWidgetState createState() => _Base64toFileWidgetState();
}

class _Base64toFileWidgetState extends State<Base64toFileWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _empIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _designationController = TextEditingController();
  final _groupController = TextEditingController();
  final _dateofjoinedController = TextEditingController();
  final _whatsupnumberController = TextEditingController();
  final _adressController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _dateofbirthController =
      TextEditingController(); // New field controller

  String _completePhoneNumber = '';
  String _completeWhatsAppNumber = '';

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_capitalizeFirstName);
    _lastNameController.addListener(_capitalizeLastName);
    _departmentController.addListener(_capitalizeDepartment);
    _designationController.addListener(_capitalizeDesignation);
    _adressController.addListener(_capitalizeAddress);
    _countryController.addListener(_capitalizeCountry);
    _stateController.addListener(_capitalizeState);
    _groupController.addListener(_capitalizeGroup); // Add listener for gender
  }

  void _capitalizeFirstName() {
    String text = _firstNameController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _firstNameController.value = _firstNameController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _capitalizeLastName() {
    String text = _lastNameController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _lastNameController.value = _lastNameController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _capitalizeDepartment() {
    String text = _departmentController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _departmentController.value = _departmentController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _capitalizeDesignation() {
    String text = _designationController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _designationController.value = _designationController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _capitalizeAddress() {
    String text = _adressController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _adressController.value = _adressController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

    void _capitalizeGroup() {
    String text = _groupController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _groupController.value = _groupController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _capitalizeState() {
    String text = _stateController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _stateController.value = _stateController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  

  void _capitalizeCountry() {
    String text = _countryController.text;
    if (text.isNotEmpty && text[0] != text[0].toUpperCase()) {
      _countryController.value = _countryController.value.copyWith(
        text: text[0].toUpperCase() + text.substring(1),
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return '';
    }
    return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_capitalizeFirstName);
    _lastNameController.removeListener(_capitalizeLastName);
    _departmentController.removeListener(_capitalizeDepartment);
    _designationController.removeListener(_capitalizeDesignation);
    _adressController.removeListener(_capitalizeAddress);
    _countryController.removeListener(_capitalizeCountry);
    _groupController.removeListener(_capitalizeGroup);
    _stateController.removeListener(_capitalizeState);
    _firstNameController.dispose();
    _groupController.dispose();
    _lastNameController.dispose();
    _designationController.dispose();
    _dateofbirthController.dispose();
    _departmentController.dispose();
    _countryController.dispose();
    _dateofjoinedController.dispose();
    _whatsupnumberController.dispose();
    _dateofbirthController.dispose();
    _countryController.dispose();
    _emailController.dispose();
    _stateController.dispose(); // Dispose gender controller
    super.dispose();

  }



  bool _isLoading = false;
  String _error = '';
  bool _isObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _error = '';
      });

      final username = _usernameController.text;
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final department = _departmentController.text;
      final phoneNumber = _completePhoneNumber;
      final empId = _empIdController.text;
      final designation = _designationController.text;
      final imageBytes = widget.base64ImageBytes!;
      final group = _groupController.text;
      final dateofjoin = _dateofjoinedController.text;
      final wahtsphonenum = _completeWhatsAppNumber;
      final address = _adressController.text;
      final state = _stateController.text;
      final country = _countryController.text;
      final dateofbirth = _dateofbirthController.text;

      // Convert image bytes to base64 string
      String base64Image = base64Encode(imageBytes);

      try {
        // Make HTTP POST request to Django API for signup
        final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/hr/api/register'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'password': password,
            'image_data': base64Image,
            'department': department,
            'designation': designation,
            'emp_id': empId,
            'phone_number': phoneNumber,
            'group': group,
            'address': address,
            'whats_up_number': wahtsphonenum,
            'date_joined': dateofjoin,
            'state': state,
            'country': country,
            'date_of_birth': dateofbirth,

            // Change 'image_url' to 'image_data'
          }),
        );

        // Check if the request was successful
        if (response.statusCode == 200) {
          print('Sign-up successful');

          await _sendAdminNotification(email);
          final responseData = jsonDecode(response.body);
          final userIsActive = responseData['user']['is_active'];
          if (!userIsActive) {
            showDialog(
              context: context,
              builder: (context) => const PopupMessageWidget(),
            );
          } else {
            // User account is active, navigate to login page
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LoginWidget(),
            ));
          }

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LoginWidget(),
          ));
         
        
         // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully registered. Please wait until your account is activated.',
              style: GoogleFonts.getFont(
                'Roboto',
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.green,
          ),
        );
      
        }
         else {
        print('Sign-up failed: ${response.body}');
        // Extract error message from response body
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'] ?? 'Unknown error occurred';
        setState(() {
          _error = 'Sign-up failed: $errorMessage';
        });

        // Show failure snackbar with specific error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign-up failed: $errorMessage',
              style: GoogleFonts.getFont(
                'Roboto',
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );
      }
    }  catch (e) {
        // Error occurred during HTTP request
        print('Error during sign-up: $e');
        setState(() {
          _error = 'An error occurred. Please try again later.';
        });
         // Show failure snackbar with generic error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred. Please try again later.',
            style: GoogleFonts.getFont(
              'Roboto',
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      }

      setState(() {
        _isLoading = false;
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill all required fields correctly.',
            style: GoogleFonts.getFont(
              'Roboto',
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sendAdminNotification(String email) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/hr/api/send_admin_notification'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'subject': 'New User Registration',
        'message': 'A new user has registered with email $email.',
        'recipients': ['farhanabadubhai@gmail.com'],
      }),
    );

    if (response.statusCode == 200) {
      print('Admin notification sent successfully');
    } else {
      print('Failed to send admin notification: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                width: 300.0,
                height: 200.0,
                child: widget.base64ImageBytes != null
                    ? Image.memory(
                        widget.base64ImageBytes!,
                        fit: BoxFit.cover,
                      )
                    : const Placeholder(),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 4.0, 0.0),
                      child: SizedBox(
                        // width: 550.0,
                        child: TextFormField(
                          controller: _empIdController,
                          decoration: InputDecoration(
                            labelText: 'EmpId',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 15.0),
                              child: FaIcon(
                                FontAwesomeIcons.idBadge,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'EmpId is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 4.0, 0.0),
                              child: TextFormField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.userPen,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'First Name is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 8.0, 0.0),
                              child: TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.userPen,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Last Name is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 4.0, 0.0),
                              child: TextFormField(
                                controller: _designationController,
                                decoration: InputDecoration(
                                  labelText: 'Designation',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.idCard,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Designation is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 4.0, 0.0),
                              child: TextFormField(
                                controller: _departmentController,
                                decoration: InputDecoration(
                                  labelText: 'Department',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.briefcase,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Department is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 8.0, 0.0),
                              child: TextFormField(
                                controller: _groupController,
                                decoration: InputDecoration(
                                  labelText: 'Group',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: Icon(
                                      Icons.group,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Group is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 8.0, 0.0),
                              child: TextFormField(
                                controller: _dateofjoinedController,
                                decoration: InputDecoration(
                                  labelText: 'Date Of Join',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintText: 'YYYY-mm-dd',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: Icon(
                                      Icons.date_range,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Date of join is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 4.0, 0.0),
                      child:
                      
                          IntlPhoneField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).black,
                                    fontSize: 15.0,
                                  ),
                          hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                       
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          counterText: '', // Remove character counter
                        ),
                        initialCountryCode: 'US',
                        onChanged: (phone) {
                          _completePhoneNumber  = phone.completeNumber;
                          print(phone.completeNumber);
                        },
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 4.0, 0.0),
                      child:
                          
                          IntlPhoneField(
                        controller: _whatsupnumberController,
                        decoration: InputDecoration(
                          labelText: 'WhatsApp Number',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).black,
                                    fontSize: 15.0,
                                  ),
                          hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          counterText: '', // Remove character counter
                        ),
                        initialCountryCode: 'US',
                        onChanged: (phone) {
                          _completeWhatsAppNumber = phone.completeNumber;
                          print(phone.completeNumber);
                        },
                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return 'WhatsApp Number is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 4.0, 0.0),
                      child: SizedBox(
                        // width: 550.0,
                        child: TextFormField(
                          autofocus: true,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                       
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 15.0),
                              child: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Invalid email format';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                     const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 4.0, 0.0),
                      child: SizedBox(
                        // width: 550.0,
                        child: TextFormField(
                          controller: _dateofbirthController,
                          decoration: InputDecoration(
                            labelText: 'Date Of Birth',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            hintText: 'YYYY-mm-dd',
                            hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                      
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 15.0),
                              child: FaIcon(
                                FontAwesomeIcons.calendar,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date of birth is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          8.0, 0.0, 4.0, 0.0),
                      child: SizedBox(
                        // width: 550.0,
                        child: TextFormField(
                          controller: _adressController,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 12.0,
                                ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 15.0),
                              child: FaIcon(
                                FontAwesomeIcons.addressCard,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Adress is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 4.0, 0.0),
          child: TextFormField(
            controller: _countryController,
            decoration: InputDecoration(
              labelText: 'Country',
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Readex Pro',
                color: FlutterFlowTheme.of(context).black,
                fontSize: 12.0,
              ),
              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Readex Pro',
                color: FlutterFlowTheme.of(context).black,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryText,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                child: FaIcon(
                  FontAwesomeIcons.earthAfrica,
                  color: Colors.black,
                  size: 15,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 12.0,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Country is required';
              }
              return null;
            },
            readOnly: true,
                onTap: () {
                  showCountryPicker(
                    
                    context: context,
                    showPhoneCode: false,
                    showWorldWide: true, 
                    onSelect: ( country) {
                      setState(() {
                        _countryController.text = country.name;
                      });
                    },
                    countryListTheme: CountryListThemeData(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      textStyle: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                  );
                },
          ),
        ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 4.0, 0.0),
                              child: TextFormField(
                                controller: _stateController,
                                decoration: InputDecoration(
                                  labelText: "State",
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                        fontSize: 12.0,
                                      ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            FlutterFlowTheme.of(context).black,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 15.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.locationDot,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "sate is required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 4.0, 0.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    SizedBox(
                      // width: 550,
                      // 
                      child: TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).black,
                        fontSize: 12.0,
                      ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Readex Pro',
                        color: FlutterFlowTheme.of(context).black,
                      ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                    child: Icon(
                      Icons.password,
                      color: Colors.black,
                      size: 18,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 12.0,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                            bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
                            bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
                            bool hasDigits = value.contains(RegExp(r'[0-9]'));
                            bool hasSpecialCharacters = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

                            if (value.length < 8 || !hasUpperCase || !hasLowerCase || !hasDigits || !hasSpecialCharacters) {
                              return 'Password must be at least 8 characters long, \ncontain upper and lower case letters, \nat least 1 number, and a special character.';
                            }

                            return null;
                          },
                        ),

                          ),
                          IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                              size: 18.0,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                                            ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
            const SizedBox(height: 20.0),
            FFButtonWidget(
              onPressed: _signUp,
              text: 'SIGNUP',
              options: FFButtonOptions(
                width: 150.0,
                height: 45.0,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                iconPadding: const EdgeInsets.all(0.0),
                color: FlutterFlowTheme.of(context).oxfordBlue,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Poppins',
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                elevation: 3.0,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ), loadingIndicatorColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
