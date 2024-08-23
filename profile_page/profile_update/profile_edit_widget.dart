
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/profile_page/profile_page_widget.dart';
import 'package:team_c/profile_page/profile_update/profile_edit_model.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
export 'profile_edit_model.dart';
import 'package:http/http.dart' as http;

class ProfileEditWidget extends StatefulWidget {
  final Map<String, dynamic> profileData;
  final String token;

  const ProfileEditWidget({super.key, required this.profileData, required this.token});

  @override
  State<ProfileEditWidget> createState() => _ProfileEditWidgetState();
}

class _ProfileEditWidgetState extends State<ProfileEditWidget> {
  late ProfileEditModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _CreateProfileEditWidgetState() {
    _selectCountry = _Country[0];
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileEditModel());
    _model.textController1 ??= TextEditingController(text: widget.profileData['phone_number']);
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textController2 ??= TextEditingController(text: widget.profileData['whats_up_number']);
    _model.textFieldFocusNode2 ??= FocusNode();
    _model.textController3 ??= TextEditingController(text: widget.profileData['date_of_birth']);
    _model.textFieldFocusNode3 ??= FocusNode();
    _model.textController4 ??= TextEditingController(text: widget.profileData['address']);
    _model.textFieldFocusNode4 ??= FocusNode();
    _selectCountry = widget.profileData['country'] ?? _Country[0];
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  String _completePhoneNumber = '';
  String _completeWhatsAppNumber = '';

  final _Country = [
    'Afghanistan',
    'Aland Islands',
    'Albania',
    'Algeria',
    'American Samoa',
    'Andorra',
    'Angola',
    'Anguilla',
    'Antarctica',
    'Antigua',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Aruba',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belgium',
    'Belize',
    'Benin',
    'Bermuda',
    'Bhutan',
    'Bolivia',
    'Bosnia And Herzegovina',
    'Botswana',
    'Bouvet Island',
    'Brazil',
    'British Indian Ocean Territory',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burma Union Myanmar',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cape Verde',
    'Cayman Island',
    'Central Africa Republic',
    'Chad',
    'Chile',
    'China',
    'Christmas Island',
    'Cocos (Keeling) Islands',
    'Colombia',
    'Commonwealth of Dominica',
    'Comoros',
    'Congo',
    'Cook Islands',
    'Costa Rica',
    'Cote d\'Ivoire',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech',
    'Czechoslovakia',
    'Dagestan',
    'Dahomey',
    'Denmark',
    'Djibouti',
    'Dominican',
    'East Timor',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Falkland Islands (Malvinas)',
    'Faroe Islands',
    'Fiji',
    'Finland',
    'France',
    'French Guiana',
    'French Polynesia',
    'French Southern Territories',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Gibraltar',
    'Greece',
    'Greenland',
    'Grenada',
    'Guadeloupe',
    'Guam',
    'Guatemala',
    'Guernsey',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Heard Island and McDonald Islands',
    'Honduras',
    'Hong Kong',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Isle of Man',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jersey',
    'Jordan',
    'Kampuchea',
    'Kazakhstan',
    'Kenya',
    'Kingston',
    'Kiribati',
    'Kosovo',
    'Kuwait',
    'Kyrgyz',
    'Kyrgyz Republic',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macau',
    'Madagascar',
    'Magnolia',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Island',
    'Martinez Islands',
    'Martinique',
    'Maryanne Island',
    'Mauritania',
    'Mauritius',
    'Mayotte',
    'Mexico',
    'Micronesia',
    'Moldavia',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Montserrat',
    'Morocco',
    'Mozambique',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'Netherlands Antilles',
    'Nevis',
    'New Caledonia',
    'New Guinea',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Niue',
    'Norfolk Island',
    'North Korea',
    'Northern Mariana Islands',
    'Norway',
    'Okinawa',
    'Other countries',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Puerto Rico',
    'Qatar',
    'Republic Of Belarus',
    'Republic Of Guinea',
    'Republic Of Macedonia',
    'Reunion',
    'Romania',
    'Russia',
    'Rwanda',
    'Ryukyu Islands',
    'Saint Kitts And Nevis',
    'Saint Lucia',
    'Saint Pierre and Miquelon',
    'Saint Vincent',
    'San Marino',
    'Sao Tome',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Island',
    'Somalia',
    'South Africa',
    'South Georgia and the South Sandwich Islands',
    'South Korea',
    'South Sudan',
    'Soviet Union',
    'Spain',
    'Sri Lanka',
    'St Christopher',
    'St Helena',
    'Sudan',
    'Sultanate Of Oman',
    'Suriname',
    'Svalbard and Jan Mayen',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syria',
    'Tahiti',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Tasmania',
    'Thailand',
    'The Democratic Republic Of Congo',
    'The Hellenic Republic',
    'Timor',
    'Togo',
    'Tokelau',
    'Tonga',
    'Tonga Islands',
    'Trinidad',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Turks and Caicos Islands',
    'Tuvalu',
    'U S A',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States Minor Outlying Islands',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican',
    'Venezuela',
    'Vietnam',
    'Virgin Islands, British',
    'Vietnam',
    'Virgin Islands, British',
    'Virgin Islands, U.S.',
    'Wallis and Futuna',
    'Western Sahara',
    'Western Samoa',
    'Yemen',
    'Yugoslavia',
    'Zambia',
    'Zimbabwe'
  ];

  String? _selectCountry;

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> editProfile(Map<String, dynamic> profileData, String jwtToken) async {
    final token = await getAuthToken();
    final String? jwt3 = token;
    final url = Uri.parse('$apiBaseUrl/hr/api/update-details');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    };

    final body = jsonEncode(profileData);

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to HistoryBalanceCopyWidget
        Navigator.of(context).pushReplacementNamed('ProfilePageWidget');
      } else {
        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update profile.'),
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
            buttonSize: 60,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () async {
              final token = await getAuthToken();
              if (token != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePageWidget(token: widget.token)),
                );
              }
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Profile',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 0,
                    ),
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 5, 12, 0.0),
                      child: Container(
                        width: double.infinity,
                        child: IntlPhoneField(
                          controller: _model.textController1,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 15.0,
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
                            counterText: '', // Remove character counter
                          ),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            _completePhoneNumber = phone.completeNumber;
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
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 5, 12, 0.0),
                      child: Container(
                        width: double.infinity,
                        child: IntlPhoneField(
                          controller: _model.textController2,
                          decoration: InputDecoration(
                            labelText: 'WhatsApp Number',
                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 15.0,
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
                            counterText: '', // Remove character counter
                          ),
                          initialCountryCode: 'IN',
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
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 5, 12, 0.0),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.textController3,
                          focusNode: _model.textFieldFocusNode3,
                          autofocus: true,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 15,
                                  letterSpacing: 0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  letterSpacing: 0,
                                ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Color(0xFF050505),
                              size: 20,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                                letterSpacing: 0,
                              ),
                          validator: _model.textController3Validator.asValidator(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 5, 12, 0.0),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _model.textController4,
                          focusNode: _model.textFieldFocusNode4,
                          autofocus: true,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  fontSize: 15,
                                  letterSpacing: 0,
                                ),
                            hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context).black,
                                  letterSpacing: 0,
                                ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            prefixIcon: Icon(
                              Icons.home,
                              color: Color(0xFF050505),
                              size: 20,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                fontSize: 16,
                                letterSpacing: 0,
                              ),
                          validator: _model.textController4Validator.asValidator(context),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5, 12, 0.0),
                      child: DropdownButtonFormField<String>(
                        value: _selectCountry,
                        items: _Country.map(
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
                            _selectCountry = newValue;
                            // You can add additional logic here if needed
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Country',
                          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).black,
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                          hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                fontSize: 12,
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          prefixIcon: Icon(
                            Icons.location_pin,
                            color: Color(0xFF050505),
                            size: 20,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              fontSize: 16,
                              letterSpacing: 0,
                            ),
                        validator: (value) {
                          return null;
                          // Add your validation logic here if needed
                        },
                      ),
                    ),
                   const SizedBox(height: TSizes.spaceBtwSections*3),
                    Center(
                      child: FFButtonWidget(
                        onPressed: () async {
                          final token = await getAuthToken();
                          // Assuming you have access to the contract ID
                          final profileData = {
                            'phone_number': _model.textController1.text,
                            'whats_up_number': _model.textController2.text,
                            'date_of_birth': _model.textController3.text,
                            'address': _model.textController4.text,
                            'country': _selectCountry,
                            // 'state': _model.textController6.text,
                          };
                          print('Profile Data: $profileData');
                
                          // Assuming this retrieves the JWT token
                
                          try {
                            await editProfile(profileData, widget.token);
                
                            final token = await getAuthToken();
                            if (token != null) {
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePageWidget(token: token),
                                ),
                              );
                            } else {
                              // Handle the case where the token is null if necessary
                              print('Token is null');
                            }
                          } catch (e) {
                            print('Error: $e');
                            // Show error pop-up
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to update document visa. Please try again.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        
                        text: 'Save',
                        options: FFButtonOptions(
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: FlutterFlowTheme.of(context).oxfordBlue,
                          textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                                letterSpacing: 0,
                              ),
                          elevation: 3,
                          borderSide: const BorderSide(
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
        ),
      ),
    );
  }
}