
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/document_record/visa_model.dart';
import 'package:team_c/document_record/visa_history.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:team_c/utils/const_api.dart';
import 'dart:convert';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CreateRecordForVisaEditWidget extends StatefulWidget {
  final Map<String, dynamic> documentvisa;
  const CreateRecordForVisaEditWidget({
    Key? key,
    required this.documentvisa,
  }) : super(key: key);


  @override
  _CreateRecordForVisaEditWidgetState createState() =>
      _CreateRecordForVisaEditWidgetState();
}

class _CreateRecordForVisaEditWidgetState
    extends State<CreateRecordForVisaEditWidget> {
   late CreateRecordForVisaModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
_CreateRecordForVisaEditWidgetState(){
  _selectCountryNames=_CountryNames[0];
  _selectDocumentType=_documentType[0];
  _selectVisaType=_visaType[0];
  _selectSponserType=_sponserType[0];
}
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateRecordForVisaModel());



    _model.textController1 ??= TextEditingController(text: widget.documentvisa['group']);
    _model.textFieldFocusNode1 ??= FocusNode();

    // _model.textController2 ??= TextEditingController(text: widget.documentvisa['country_name']);
    // _model.textFieldFocusNode2 ??= FocusNode();

    // _model.textController3 ??= TextEditingController(text: widget.documentvisa['document_type']);
    // _model.textFieldFocusNode3 ??= FocusNode();
  _selectCountryNames=widget.documentvisa['Visacountry_name'];
  _selectDocumentType=widget.documentvisa['Visadocument_type'];
    _model.textController4 ??= TextEditingController(text: widget.documentvisa['Visacategory']);
    _model.textFieldFocusNode4 ??= FocusNode();

    _model.textController5 ??= TextEditingController(text: widget.documentvisa['Visasub_category']);
    _model.textFieldFocusNode5 ??= FocusNode();

    _model.textController6 ??= TextEditingController(text: widget.documentvisa['Visadocument_number']);
    _model.textFieldFocusNode6 ??= FocusNode();

    _model.textController7 ??= TextEditingController(text: widget.documentvisa['Visaissued_by']);
    _model.textFieldFocusNode7 ??= FocusNode();

    _model.textController8 ??= TextEditingController(text: widget.documentvisa['Visaissued_at']);
    _model.textFieldFocusNode8 ??= FocusNode();

    _model.textController9 ??= TextEditingController(text: widget.documentvisa['Visaissued_date']);
    _model.textFieldFocusNode9 ??= FocusNode();

    _model.textController10 ??= TextEditingController(text: widget.documentvisa['Visaissuing_authority']);
    _model.textFieldFocusNode10 ??= FocusNode();

    _model.textController11 ??= TextEditingController(text: widget.documentvisa['Visavalid_from']);
    _model.textFieldFocusNode11 ??= FocusNode();

    _model.textController12 ??= TextEditingController(text: widget.documentvisa['Visavalid_to']);
    _model.textFieldFocusNode12 ??= FocusNode();

    _model.textController13 ??= TextEditingController(text: widget.documentvisa['Visaverified_by']);
    _model.textFieldFocusNode13 ??= FocusNode();

    _model.textController14 ??= TextEditingController(text: widget.documentvisa['Visaverified_date']);
    _model.textFieldFocusNode14 ??= FocusNode();

    _model.textController15 ??= TextEditingController(text: widget.documentvisa['visa_number']);
    _model.textFieldFocusNode15 ??= FocusNode();

    _selectVisaType=widget.documentvisa['visa_type'];
    _selectSponserType= widget.documentvisa['sponsor_type'];
    _selectSponserName=widget.documentvisa['sponsor_name'];
    _selectSponserRelationship=widget.documentvisa['sponsor_relationship'];
    _model.textController20 ??= TextEditingController(text: widget.documentvisa['sponsor_number']);
    _model.textFieldFocusNode20 ??= FocusNode();
    _selectNationalityNames=widget.documentvisa['sponsor_nationality'];
    _selectEmirate=widget.documentvisa['emirate'];
    _model.empId =  widget.documentvisa['emp_id'];
    _model.username =  widget.documentvisa['username'];
    _model.email =  widget.documentvisa['email']; // Initialize empId here
    _model.department = widget.documentvisa['department'];
    
  }

  
  final _CountryNames = [
    'Afghanistan', 'Aland Islands', 'Albania', 'Algeria', 'American Samoa', 'Andorra',
    'Angola', 'Anguilla', 'Antarctica', 'Antigua', 'Antigua and Barbuda', 'Argentina',
    'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain',
    'Bangladesh', 'Barbados', 'Belgium', 'Belize', 'Benin', 'Bermuda', 'Bhutan',
    'Bolivia', 'Bosnia And Herzegovina', 'Botswana', 'Bouvet Island', 'Brazil',
    'British Indian Ocean Territory', 'Brunei', 'Bulgaria', 'Burkina Faso',
    'Burma Union Myanmar', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Cape Verde',
    'Cayman Island', 'Central Africa Republic', 'Chad', 'Chile', 'China',
    'Christmas Island', 'Cocos (Keeling) Islands', 'Colombia', 'Commonwealth of Dominica',
    'Comoros', 'Congo', 'Cook Islands', 'Costa Rica', 'Cote d\'Ivoire', 'Croatia', 'Cuba',
    'Cyprus', 'Czech', 'Czechoslovakia', 'Dagestan', 'Dahomey', 'Denmark', 'Djibouti',
    'Dominican', 'East Timor', 'Ecuador', 'Egypt', 'El Salvador', 'Eritrea', 'Estonia',
    'Ethiopia', 'Falkland Islands (Malvinas)', 'Faroe Islands', 'Fiji', 'Finland', 'France',
    'French Guiana', 'French Polynesia', 'French Southern Territories', 'Gabon', 'Gambia',
    'Georgia', 'Germany', 'Ghana', 'Gibraltar', 'Greece', 'Greenland', 'Grenada',
    'Guadeloupe', 'Guam', 'Guatemala', 'Guernsey', 'Guinea', 'Guinea-Bissau', 'Guyana',
    'Haiti', 'Heard Island and McDonald Islands', 'Honduras', 'Hong Kong', 'Hungary',
    'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Isle of Man', 'Israel',
    'Italy', 'Jamaica', 'Japan', 'Jersey', 'Jordan', 'Kampuchea', 'Kazakhstan', 'Kenya',
    'Kingston', 'Kiribati', 'Kosovo', 'Kuwait', 'Kyrgyz', 'Kyrgyz Republic', 'Kyrgyzstan',
    'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania',
    'Luxembourg', 'Macau', 'Madagascar', 'Magnolia', 'Malawi', 'Malaysia', 'Maldives',
    'Mali', 'Malta', 'Marshall Island', 'Martinez Islands', 'Martinique', 'Maryanne Island',
    'Mauritania', 'Mauritius', 'Mayotte', 'Mexico', 'Micronesia', 'Moldavia', 'Monaco',
    'Mongolia', 'Montenegro', 'Montserrat', 'Morocco', 'Mozambique', 'Namibia', 'Nauru',
    'Nepal', 'Netherlands', 'Netherlands Antilles', 'Nevis', 'New Caledonia', 'New Guinea',
    'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Norfolk Island', 'North Korea',
    'Northern Mariana Islands', 'Norway', 'Okinawa', 'Other countries', 'Pakistan', 'Palau',
    'Palestine', 'Panama', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal',
    'Puerto Rico', 'Qatar', 'Republic Of Belarus', 'Republic Of Guinea',
    'Republic Of Macedonia', 'Reunion', 'Romania', 'Russia', 'Rwanda', 'Ryukyu Islands',
    'Saint Kitts And Nevis', 'Saint Lucia', 'Saint Pierre and Miquelon', 'Saint Vincent',
    'San Marino', 'Sao Tome', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles',
    'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Island', 'Somalia',
    'South Africa', 'South Georgia and the South Sandwich Islands', 'South Korea',
    'South Sudan', 'Soviet Union', 'Spain', 'Sri Lanka', 'St Christopher', 'St Helena',
    'Sudan', 'Sultanate Of Oman', 'Suriname', 'Svalbard and Jan Mayen', 'Swaziland',
    'Sweden', 'Switzerland', 'Syria', 'Tahiti', 'Taiwan', 'Tajikistan', 'Tanzania',
    'Tasmania', 'Thailand', 'The Democratic Republic Of Congo', 'The Hellenic Republic',
    'Timor', 'Togo', 'Tokelau', 'Tonga', 'Tonga Islands', 'Trinidad', 'Tunisia', 'Turkey',
    'Turkmenistan', 'Turks and Caicos Islands', 'Tuvalu', 'U S A', 'Uganda', 'Ukraine',
    'United Arab Emirates', 'United Kingdom', 'United States Minor Outlying Islands',
    'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican', 'Venezuela', 'Vietnam',
    'Virgin Islands, British', 'Vietnam', 'Virgin Islands, British', 'Virgin Islands, U.S.',
    'Wallis and Futuna', 'Western Sahara', 'Western Samoa', 'Yemen', 'Yugoslavia', 'Zambia',
    'Zimbabwe'];

  final _documentType=['AE_VISA'];
  final _visaType=['Family Visa','Residence Permit', 'Visit Visa'];
  final _sponserType = ['Company Sponsored','Family Sponsored'];
  final _sponserName = ['Advantage Taxi LLC','Al Yousuf Agricultural and Landscaping LLC','Al Yousuf Computer & Telecommunications (L.L.C.)','Al Yousuf Computers & Telecommunications Abu Dhabi','Al Yousuf Electronics LLC',
    'Al Yousuf Electronics LLC - Abu Dhabi',
    'Al Yousuf International Construction LLC',
    'Al Yousuf LLC',
    'Al Yousuf LLC - Abu Dhabi',
    'Al Yousuf Motors LLC',
    'Al Yousuf Motors LLC - Abu Dhabi',
    'Al Yousuf Real Estate LLC',
    'Al Yousuf Security Controls and Alarms LLC',
    'Al Yousuf Sports Equipment LLC',
    'Al Yousuf Sports Equipment LLC - Abu Dhabi',
    'Alyousuf Technical Solutions L.L.C.',
    'BIG BLUE MARINE EQUIPMENTS LLC',
    'Back on Track LLC',
    'Delux Limousine LLC',
    'Fujitech Co Ltd Dubai BR',
    'Future Technology (L.L.C.)',
    'Future Technology - LLC - Abu Dhabi',
    'Imperbit Menmbrane Industries LLC',
    'Jebel Ali Free Zone',
    'Nipon Kaiji Kyokai Dubai',
    'Others',
    'Sharjah Airport',
    'Yamaha Motors Company',];
  final _NationalityNames = [
    'Afghanistan', 'Aland Islands', 'Albania', 'Algeria', 'American Samoa', 'Andorra',
    'Angola', 'Anguilla', 'Antarctica', 'Antigua', 'Antigua and Barbuda', 'Argentina',
    'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain',
    'Bangladesh', 'Barbados', 'Belgium', 'Belize', 'Benin', 'Bermuda', 'Bhutan',
    'Bolivia', 'Bosnia And Herzegovina', 'Botswana', 'Bouvet Island', 'Brazil',
    'British Indian Ocean Territory', 'Brunei', 'Bulgaria', 'Burkina Faso',
    'Burma Union Myanmar', 'Burundi', 'Cambodia', 'Cameroon', 'Canada', 'Cape Verde',
    'Cayman Island', 'Central Africa Republic', 'Chad', 'Chile', 'China',
    'Christmas Island', 'Cocos (Keeling) Islands', 'Colombia', 'Commonwealth of Dominica',
    'Comoros', 'Congo', 'Cook Islands', 'Costa Rica', 'Cote d\'Ivoire', 'Croatia', 'Cuba',
    'Cyprus', 'Czech', 'Czechoslovakia', 'Dagestan', 'Dahomey', 'Denmark', 'Djibouti',
    'Dominican', 'East Timor', 'Ecuador', 'Egypt', 'El Salvador', 'Eritrea', 'Estonia',
    'Ethiopia', 'Falkland Islands (Malvinas)', 'Faroe Islands', 'Fiji', 'Finland', 'France',
    'French Guiana', 'French Polynesia', 'French Southern Territories', 'Gabon', 'Gambia',
    'Georgia', 'Germany', 'Ghana', 'Gibraltar', 'Greece', 'Greenland', 'Grenada',
    'Guadeloupe', 'Guam', 'Guatemala', 'Guernsey', 'Guinea', 'Guinea-Bissau', 'Guyana',
    'Haiti', 'Heard Island and McDonald Islands', 'Honduras', 'Hong Kong', 'Hungary',
    'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Isle of Man', 'Israel',
    'Italy', 'Jamaica', 'Japan', 'Jersey', 'Jordan', 'Kampuchea', 'Kazakhstan', 'Kenya',
    'Kingston', 'Kiribati', 'Kosovo', 'Kuwait', 'Kyrgyz', 'Kyrgyz Republic', 'Kyrgyzstan',
    'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania',
    'Luxembourg', 'Macau', 'Madagascar', 'Magnolia', 'Malawi', 'Malaysia', 'Maldives',
    'Mali', 'Malta', 'Marshall Island', 'Martinez Islands', 'Martinique', 'Maryanne Island',
    'Mauritania', 'Mauritius', 'Mayotte', 'Mexico', 'Micronesia', 'Moldavia', 'Monaco',
    'Mongolia', 'Montenegro', 'Montserrat', 'Morocco', 'Mozambique', 'Namibia', 'Nauru',
    'Nepal', 'Netherlands', 'Netherlands Antilles', 'Nevis', 'New Caledonia', 'New Guinea',
    'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Norfolk Island', 'North Korea',
    'Northern Mariana Islands', 'Norway', 'Okinawa', 'Other countries', 'Pakistan', 'Palau',
    'Palestine', 'Panama', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal',
    'Puerto Rico', 'Qatar', 'Republic Of Belarus', 'Republic Of Guinea',
    'Republic Of Macedonia', 'Reunion', 'Romania', 'Russia', 'Rwanda', 'Ryukyu Islands',
    'Saint Kitts And Nevis', 'Saint Lucia', 'Saint Pierre and Miquelon', 'Saint Vincent',
    'San Marino', 'Sao Tome', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles',
    'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Island', 'Somalia',
    'South Africa', 'South Georgia and the South Sandwich Islands', 'South Korea',
    'South Sudan', 'Soviet Union', 'Spain', 'Sri Lanka', 'St Christopher', 'St Helena',
    'Sudan', 'Sultanate Of Oman', 'Suriname', 'Svalbard and Jan Mayen', 'Swaziland',
    'Sweden', 'Switzerland', 'Syria', 'Tahiti', 'Taiwan', 'Tajikistan', 'Tanzania',
    'Tasmania', 'Thailand', 'The Democratic Republic Of Congo', 'The Hellenic Republic',
    'Timor', 'Togo', 'Tokelau', 'Tonga', 'Tonga Islands', 'Trinidad', 'Tunisia', 'Turkey',
    'Turkmenistan', 'Turks and Caicos Islands', 'Tuvalu', 'U S A', 'Uganda', 'Ukraine',
    'United Arab Emirates', 'United Kingdom', 'United States Minor Outlying Islands',
    'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican', 'Venezuela', 'Vietnam',
    'Virgin Islands, British', 'Vietnam', 'Virgin Islands, British', 'Virgin Islands, U.S.',
    'Wallis and Futuna', 'Western Sahara', 'Western Samoa', 'Yemen', 'Yugoslavia', 'Zambia',
    'Zimbabwe'];
    final _emirates=['Abu Dhabi','Ajman','Al Ain' ,'Dubai', 'Fujairah', 'Ras al-Khaimah', 'Sharjah', 'Umm al-Qaiwain'];

  final _sponserRelationship = ['Brother','Daughter','Father','Husband','Mom Husband','Mother','Not Related','Sister','Son','Wife',];

   String? _selectCountryNames;
   String? _selectDocumentType;
   String? _selectVisaType;
   String? _selectSponserType;
   String? _selectSponserName;
   String? _selectSponserRelationship;
   String? _selectNationalityNames;
   String? _selectEmirate;


  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }


  Future<String?> getAuthToken() async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

 Future<void> editDocumentVisa(int visaId, Map<String, dynamic> visaData, String jwtToken) async  {
 final token = await getAuthToken();
  
  
  final String? jwt3 = token;
  final url = Uri.parse('$apiBaseUrl/hr/api/Document-visa/$visaId');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt3',
  };

  final body = jsonEncode(visaData);

  try {
    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document visa updated successfully.'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to HistoryBalanceCopyWidget
      Navigator.of(context).pushReplacementNamed('DocumentVisaHistoryWidget');
    } else {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update Document visa.'),
          backgroundColor: Colors.red,
        ),
      );
      // Do not navigate to HistoryBalanceCopyWidget on error
    }
  } catch (e) {
    // Show error snackbar
    // Do not navigate to HistoryBalanceCopyWidget on error
  }
}

Future<void> _sendAdminNotification(String email) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/hr/api/send_admin_notification'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'subject': 'Document Visa request',
        'message': ' Document Visa request by Employee with email $email.',
        'recipients': ['rafiqshahid3131@gmail.com'],
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
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0xFF002147),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
             Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DocumentVisaHistoryWidget()),
              );
            },
          ),
          title: Text(
            'Update Document For Visa',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 0,
            ),
          ),
          
          centerTitle: false,
          elevation: 2,
        ),

        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: Text(
                        'Document Information',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
                 
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
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
                                '${_model.username}',
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
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
                                 '${_model.empId}',
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
                     padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
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
                              Icons.email_outlined,
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
                                '${_model.email}',
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
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
                                   '${_model.department}',
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                              child: TextFormField(
                                controller: _model.textController1,
                                focusNode: _model.textFieldFocusNode1,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  hintText: 'Business Group',
                                  hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                  prefixIcon: Icon(
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
                                textAlign: TextAlign.start,
                                // Validator added here
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Business Group is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
              
                    Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                     padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Extra Information',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
              Align(
                alignment: const AlignmentDirectional(-1, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                  child: Text(
                    'Country Name',
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
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                child: DropdownButtonFormField<String>(
                  value: _selectCountryNames,
                  items: _CountryNames.map(
                    (e) => DropdownMenuItem(
                      child: SizedBox(
                        width: 200, // Set the desired maximum width here
                        child: Text(
                          e,
                          overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
                        ),
                      ),
                      value: e,
                    ),
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectCountryNames = newValue;
                      // You can add additional logic here if needed
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Select Country Name',
                    hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                      Icons.add_location,
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
                  validator: (value) {
                    // Add your validation logic here if needed
                  },
                ),
              ),
                                
                  Padding(
                       padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                        child: RichText(textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(text: '*',style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',color: FlutterFlowTheme.of(context).fireEngineRed,fontSize: 16,letterSpacing: 0,fontWeight: FontWeight.bold,),),
                                 TextSpan(text: 'Document Type',
                                
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                                
                                )
                              ],
                              style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Readex Pro',letterSpacing: 0,
                            ),
                          ),
                          )
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectDocumentType,
                        items: _documentType.map(
                          (e) => DropdownMenuItem(child: Text(e), value: e),
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectDocumentType = newValue;
                            // You can add additional logic here if needed
                          });
                        },
                        decoration: InputDecoration(
                          
                          hintText: 'Select Document Type',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                            Icons.document_scanner_sharp,
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
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Category',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1, -1),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
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
                          hintText: 'Category',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                            Icons.grid_view_rounded,
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
                        textAlign: TextAlign.start,
                        validator:
                            _model.textController4Validator.asValidator(context),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Sub Category',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController5,
                      focusNode: _model.textFieldFocusNode5,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Sub Category',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.subject_rounded,
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
                      validator:
                          _model.textController5Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Document Number',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController6,
                      focusNode: _model.textFieldFocusNode6,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Document Number',
                       hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.file_copy,
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
                      validator:
                          _model.textController6Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Issued By',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController7,
                      focusNode: _model.textFieldFocusNode7,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Name of Person?Department',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.checklist_sharp,
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
                      validator:
                          _model.textController7Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Issued At',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                    child: TextFormField(
                      controller: _model.textController8,
                      focusNode: _model.textFieldFocusNode8,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Issued At',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.checklist_sharp,
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
                      validator:
                          _model.textController8Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Issued Date',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController9,
                      focusNode: _model.textFieldFocusNode9,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.calendar_month,
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
                      validator:
                          _model.textController9Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Issuing Authority',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController10,
                      focusNode: _model.textFieldFocusNode10,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Name of organization',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.admin_panel_settings,
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
                      validator:
                          _model.textController10Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                     padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Valid From',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController11,
                      focusNode: _model.textFieldFocusNode11,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.calendar_month,
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
                      validator:
                          _model.textController11Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                     padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Valid To',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController12,
                      focusNode: _model.textFieldFocusNode12,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.calendar_month,
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
                      validator:
                          _model.textController12Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Verified By',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController13,
                      focusNode: _model.textFieldFocusNode13,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Name of Person or Department',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                          Icons.verified_user,
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
                      textAlign: TextAlign.start,
                      validator:
                          _model.textController13Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Verified Date',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController14,
                      focusNode: _model.textFieldFocusNode14,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                          Icons.calendar_month,
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
                      textAlign: TextAlign.start,
                      validator:
                          _model.textController14Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Additional Information',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 15
                              ,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Visa Number',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: TextFormField(
                      controller: _model.textController15,
                      focusNode: _model.textFieldFocusNode15,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Visa Number',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
                                  ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.edit_document,
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
                      validator:
                          _model.textController15Validator.asValidator(context),
                    ),
                  ),
                  
                   Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                        child: RichText(textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(text: '*',style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',color: FlutterFlowTheme.of(context).fireEngineRed,fontSize: 16,letterSpacing: 0,fontWeight: FontWeight.bold,),),
                                 TextSpan(text: 'Visa Type',
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),)
                              ],
                              style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Readex Pro',letterSpacing: 0,
                            ),
                          ),
                          )
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectVisaType,
                        items: _visaType.map(
                          (e) => DropdownMenuItem(child: Text(e), value: e),
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectVisaType = newValue;
                            // You can add additional logic here if needed
                          });
                        },
                        decoration: InputDecoration(
                          
                          hintText: 'Select visa type',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                            Icons.type_specimen,
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
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                        child: RichText(textScaler: MediaQuery.of(context).textScaler,
                          text: TextSpan(
                            children: [
                              TextSpan(text: '*',style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',color: FlutterFlowTheme.of(context).fireEngineRed,fontSize: 16,letterSpacing: 0,fontWeight: FontWeight.bold,),),
                                 TextSpan(text: 'Sponsor Type',
                                 style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),)
                              ],
                              style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Readex Pro',letterSpacing: 0,
                            ),
                          ),
                          )
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectSponserType,
                        items: _sponserType.map(
                          (e) => DropdownMenuItem(child: Text(e), value: e),
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectSponserType = newValue;
                            // You can add additional logic here if needed
                          });
                        },
                        decoration: InputDecoration(
                          
                          hintText: 'Select sponsor type',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                            Icons.handshake,
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
                    Align(
    alignment: const AlignmentDirectional(-1, 0),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
      child: Text(
        'Sponsor Name',
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectSponserName,
                        items: _sponserName.map(
                          (e) => DropdownMenuItem(
                            child: SizedBox(
                              width: 200, // Set the desired maximum width here
                              child: Text(
                                e,
                                overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
                              ),
                            ),
                            value: e,
                          ),
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectSponserName = newValue;
                            // You can add additional logic here if needed
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Sponsor Name',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                        validator: (value) {
                          // Add your validation logic here if needed
                        },
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                        child: Text(
                          'Sponsor\'s Relationship',
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
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                        child: DropdownButtonFormField<String>(
                          value: _selectSponserRelationship,
                          items: _sponserRelationship.map(
                            (e) => DropdownMenuItem(child: Text(e), value: e),
                          ).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectSponserRelationship = newValue;
                              // You can add additional logic here if needed
                            });
                          },
                          decoration: InputDecoration(
                            
                            hintText: 'Select sponsor Relationship',
                            hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                              Icons.family_restroom,
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
                    Align(
                      alignment: const AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                        child: Text(
                          'Sponsor\'s Number',
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
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                      child: TextFormField(
                        controller: _model.textController20,
                        focusNode: _model.textFieldFocusNode20,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Poppins',
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                          hintText: 'Sponsor\'s Number',
                          hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                            Icons.numbers_outlined,
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
                        textAlign: TextAlign.start,
                        validator:
                            _model.textController20Validator.asValidator(context),
                      ),
                    ),
                    Align(
    alignment: const AlignmentDirectional(-1, 0),
    child: Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
      child: Text(
        'Select Nationality',
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
  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
  child: DropdownButtonFormField<String>(
    value: _selectNationalityNames,
    items: _NationalityNames.map(
      (e) => DropdownMenuItem(
        child: SizedBox(
          width: 200, // Set the desired maximum width here
          child: Text(
            e,
            overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
          ),
        ),
        value: e,
      ),
    ).toList(),
    onChanged: (newValue) {
      setState(() {
        _selectNationalityNames = newValue;
        // You can add additional logic here if needed
      });
    },
    decoration: InputDecoration(
      hintText: 'Select Nationality',
      hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
        Icons.map,
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
    validator: (value) {
      // Add your validation logic here if needed
    },
  ),
),
                    Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15,0, 0.0),
                      child: Text(
                        'Emirate',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectEmirate,
                      items: _emirates.map(
                        (e) => DropdownMenuItem(
                          child: SizedBox(
                            width: 200, // Set the desired maximum width here
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis, // Truncate long text with ellipsis
                            ),
                          ),
                          value: e,
                        ),
                      ).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectEmirate = newValue;
                          // You can add additional logic here if needed
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Emirate',
                        hintStyle:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0,
                                   
                                    
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
                          Icons.flight_takeoff,
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
                      validator: (value) {
                        // Add your validation logic here if needed
                      },
                    ),
                  ),
                const SizedBox(height: 30.0,),
               Center(
                 child: FFButtonWidget(
                      onPressed: () async {
                        final token = await getAuthToken();
                        final visaId = widget.documentvisa['id']; // Assuming you have access to the contract ID
                        final visaData = {
                            'emp_id': _model.empId,
                            'username': _model.username,
                            'department': _model.department,
                            'email': _model.email,
                            'group': _model.textController1.text,
                 
                            'Visacountry_name': _selectCountryNames,
                            'Visadocument_type': _selectDocumentType,
                            'Visacategory': _model.textController4.text,
                              
                            'Visasub_category': _model.textController5.text,
                            'Visadocument_number': _model.textController6.text,
                            'Visaissued_by': _model.textController7.text,
                 
                            'Visaissued_at': _model.textController8.text,
                            'Visaissued_date': _model.textController9.text,
                            'Visaissuing_authority': _model.textController10.text,
                 
                            'Visavalid_from': _model.textController11.text,
                            'Visavalid_to': _model.textController12.text,
                            'Visaverified_by': _model.textController13.text,
                 
                            'Visaverified_date': _model.textController14.text,
                            'visa_number': _model.textController15.text,
                            'visa_type': _selectVisaType,
                 
                            'sponsor_type': _selectSponserType,
                            'sponsor_name': _selectSponserName,
                            'sponsor_relationship': _selectSponserRelationship,
                 
                            'sponsor_number': _model.textController20.text,
                            'sponsor_nationality': _selectNationalityNames,
                            'emirate': _selectEmirate,
                 
                          
                        };
                        
                        final jwtToken = token; // Assuming this retrieves the JWT token
                 
                        try {
                          await editDocumentVisa(visaId, visaData, jwtToken!);
                          
                          // Navigate to next page if contract is updated successfully
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DocumentVisaHistoryWidget(),
                            ),
                          );
                        } catch (e) {
                          print('Error: $e');
                          // Show error pop-up
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to update document visa. Please try again.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      text: 'Update',
                      options: FFButtonOptions(
                        height: 40,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color:Color(0xFF002147),
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0,
                        ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ), 
                      loadingIndicatorColor: Colors.white,
                    ),
               ),

              ],
            ),
          ),
        ),
      ),
    ));
  }
}








