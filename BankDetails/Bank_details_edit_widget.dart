import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/BankDetails/Bank_detail_model.dart';
import 'package:team_c/BankDetails/Bank_details_history.dart';
import 'package:team_c/auth/custom_auth/auth_util.dart';

import 'package:http/http.dart' as http;
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/flutter_flow/flutter_flow_icon_button.dart';
import 'package:team_c/flutter_flow/flutter_flow_theme.dart';
import 'package:team_c/flutter_flow/flutter_flow_util.dart';
import 'package:team_c/flutter_flow/flutter_flow_widgets.dart';
import 'package:team_c/leaveManagement/leave_management_history_widget.dart';
import 'package:team_c/utils/const_api.dart';

class EditBankDetailsManagement extends StatefulWidget {
  // final String leaveRecordId;
   final Map<String, dynamic> BankAccount;
  const EditBankDetailsManagement(
      {super.key,  required this.BankAccount});

  @override
  State<EditBankDetailsManagement> createState() =>
      _EditBankDetailsManagementState();
}

class _EditBankDetailsManagementState extends State<EditBankDetailsManagement> {
  late BankDetailsCopyModel _model;
    final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  bool _isLoading = false;

  _EditBankDetailsManagementState() {
    _selectedbankNameType = _bankNamesType[0];
  }
  final _bankNamesType = [
    'Abu Dhabi',
    'Abu Dhabi Commercial Bank',
    'Abu Dhabi Islamic Bank',
    'Ahmed Al Amery Exchange Est - Abu Dhabi',
    'Ahmed Al Hussain Exchange Est - Dubai',
    'Ain Al Faydah Exchange - Al Ain',
    'Ajman Bank',
    'Al Ahalia Money Exchange Bureau - Abu Dhabi',
    'Al Ahli Bank Of Kuwait K.S.C.',
    'Al Ansari Exchange LLC',
    'Al Ansari Exchange Services - Al Ain',
    'Al Azhar Exchange - Dubai',
    'Al Bader Exchange - Abu Dhabi',
    'Al Balooch Money Exchange - Al Ain',
    'Al Dahab Exchange Dubai',
    'Al Darmaki Exchange Est - Dubai',
    'Al Dhahery Exchange',
    'Al Dhahery Money Exchange - Al Ain',
    'Al Dinar Exchange Company',
    'Al Falah Exchange Company - Abu Dhabi',
    'Al Fardan Exchange - Abu Dhabi',
    'Al Fuad Exchange - Dubai',
    'Al Gergawi Exchange LLC - Dubai',
    'Al Ghurair Exchange - Dubai',
    'Al Ghurair International Exchange - Dubai',
    'Al Hadha Exchange LLC - Dubai',
    'Al Hamed Exchange - Sharjah',
    'Al Hamriyah Exchange - Dubai',
    'Al Hilal Bank',
    'Al Jarwan Money Exchange - Sharjah',
    'Al Masood Exchange - Abu Dhabi',
    'Al Mazroui Exchange Est - Abu Dhabi',
    'Al Modawallah Exchange - Dubai',
    'Al Mona Exchange CO LLC - Dubai',
    'Al Mussabah Exchange - Dubai',
    'Al Nafees Exchange LLC - Dubai',
    'Al Ne\'Emah Exchange CO LLC - Dubai',
    'Al Nibal International Exchange',
    'Al Rajihi Exchange Company LLC - Dubai',
    'Al Razouki Int\'L Exchange CO LLC - Dubai',
    'Al Rostamani Exchange - Dubai',
    'Al Zari & Al Fardan Exchange LLC - Sharjah',
    'Al Zarooni Exchange - Dubai',
    'Alfalah Exchange Company',
    'Alukkass Exchange Dubai',
    'Arab African International Bank',
    'Arab Bank - Qatar',
    'Arab Bank PLC',
    'Arabian Exchange Co - Abu Dhabi',
    'Ary International Exchange - Dubai',
    'Asia Exchange Centre - Dubai',
    'Aziz Exchange CO LLC - Dubai',
    'Bank MISR',
    'Bank Melli Iran',
    'Bank Of Baroda - Al Ain',
    'Bank Of Baroda - Deira',
    'Bank Of Baroda - Dubai HO',
    'Bank Of Baroda - RAK',
    'Bank Of Baroda - Sharjah',
    'Bank Of Sharjah',
    'Bank Saderat Iran',
    'Banque Libanaise(France)',
    'Banque Paribas',
    'Barclays',
    'Bhagwandas Jethanand And Sons - Sharjah',
    'Bin Bakheet Exchange Est - Ajman',
    'Bin Belaila Exchange CO LLC',
    'Bin Belaila Exchange CO LLC - Dubai',
    'Blom Bank France',
    'C3',
    'Cash Express Exchange Est - Dubai',
    'Citibank N.A.',
    'City Exchange LLC - Dubai',
    'Commercial Bank Of Dubai',
    'Commercial Bank-Qatar',
    'Credit Agricole',
    'Daniba International Exchange - Dubai',
    'Day Exchange LLC - Dubai',
    'Dinar Exchange - Dubai',
    'Doha Bank',
    'Dubai Bank PJSC',
    'Dubai Exchange Centre LLC - Dubai',
    'Dubai Express Exchange',
    'Dubai Islamic Bank',
    'Dunia',
    'Economic Exchange',
    'Economic Exchange Centre',
    'El Nilein Bank',
    'Emirates & East India Exchange - Sharjah',
    'Emirates India International Exchange - Sharjah',
    'Emirates Islamic Bank',
    'Emirates NBD',
    'Federal Exchange - Dubai',
    'Finance House',
    'First Gulf Bank',
    'First Gulf Exchange Centre - Dubai',
    'Future Exchange',
    'GCC Exchange',
    'Global Exchange',
    'Gomti Exchange LLC - Dubai',
    'Gulf Express Exchange - Dubai',
    'Gulf Int\'L Exchange CO LLC - Dubai',
    'HSBC Financial Services',
    'HSBC Middle East',
    'Habib Bank A.G. Zurich',
    'Habib Bank Limited',
    'Habib Exchange CO LLC - Sharjah',
    'Hadi Express Exchange - Dubai',
    'Harib Sultan Exchange - Abu Dhabi',
    'Horizon Exchange - Dubai',
    'International Development Exchange - Dubai',
    'Invest Bank',
    'Janata Bank',
    'Jumana Exchange Est - Dubai',
    'Kanoo Exchange - Dubai',
    'Khalil Al Fardan Exchange - Dubai',
    'Khalili Exchange CO LLC - Dubai',
    'Lari Exchange Est - Abu Dhabi',
    'Lee La Megh Exchange LLC - Dubai',
    'Lloyds Bank',
    'Lulu Exchange',
    'Malik Exchange - Abu Dhabi',
    'Mashreq PSC',
    'Multinet Trust Exchange LLC - Dubai',
    'Nanikdas Nathoomal Exchange CO LLC - Dubai',
    'Naser Khoory Exchange Est - Abu Dhabi',
    'Nasim Al Barari Exchange',
    'National Bank Of Abu Dhabi',
    'National Bank Of Bahrain',
    'National Bank Of Fujairah',
    'National Bank Of Kuwait',
    'National Bank Of Oman',
    'National Bank Of Umm Al Qaiwain',
    'National Exchange CO - Abu Dhabi',
    'Noor Islamic Bank',
    'Oasis Exchange',
    'Orient Exchange COLLC - Dubai',
    'Others',
    'Pacific Exchange - Dubai',
    'Qatar National Bank',
    'Rafidain Bank',
    'Rak Bank',
    'Redha Al Ansari Exchange Est - Dubai',
    'Reems Exchange - Dubai',
    'Royal Bank Of Canada',
    'Royal Bank Of Scotland',
    'Royal Exchange CO LLC',
    'Sa\'Ad Exchange - Fujairah',
    'Sabah Exchange - Sharjah',
    'Sajwani Exchange - Dubai',
    'Salim Exchange - Sharjah',
    'Samba Financial Group',
    'Sana\'A Exchange - Dubai',
    'Sawan Exchange CO LLC - Dubai',
    'Seidco',
    'Shaheen Money Exchange LLC - Dubai',
    'Sharaf Exchange',
    'Sharjah International Exchange - Sharjah',
    'Sharjah Islamic Bank',
    'Standard Chartered Bank',
    'Tabra & Al Nebal Exchange - Dubai',
    'Tahir Exchange Est - Dubai',
    'Taymour & Abou Harb Exchange CO LLC - Sharjah',
    'U.A.E. Exchange Centre LLC - Dubai',
    'Union Exchange - Abu Dhabi',
    'Union National Bank',
    'United Arab Bank',
    'United Bank Ltd',
    'Universal Exchange Centre - Dubai',
    'Wall Street Exchange Centre LLC - Dubai',
    'Waseela Equity',
    'Workers Equity Holdings',
    'Zahra Al Yousuf Exchange - Dubai',
    'Zareen Exchange',
  ];


  String? _selectedbankNameType;

  @override
  void initState() {
    super.initState();
     _fetchUserDetails();

     _model = createModel(context, () => BankDetailsCopyModel());

   

   _model.textController1 ??=
        TextEditingController(text: widget.BankAccount['group']);
  _model.textFieldFocusNode1 ??= FocusNode();

   _selectedbankNameType = widget.BankAccount['bank_name']??'Bank of Sharjah';


  _model.textController2 ??=
        TextEditingController(text: widget.BankAccount['branch']);
  _model.textFieldFocusNode2 ??= FocusNode();

   _model.textController3 ??=
        TextEditingController(text: widget.BankAccount['iban_number']);
   _model.textFieldFocusNode3 ??= FocusNode();

  _model.textController4??=
        TextEditingController(text: widget.BankAccount['Bankstart_date']);
  _model.textFieldFocusNode4??= FocusNode();

  _model.textController5??= TextEditingController(
        text: widget.BankAccount['bank_code']);
   _model.textFieldFocusNode5 ??= FocusNode();

   _model.textController6??= TextEditingController(
        text: widget.BankAccount['bankaccount_comment']);
  _model.textFieldFocusNode6 ??= FocusNode();






    _model.empId =  widget.BankAccount['emp_id'];
    _model.username =  widget.BankAccount['username'];
    _model.email =  widget.BankAccount['email']; // Initialize empId here
    _model.department = widget.BankAccount['department'];

    print('${_model.textController1}');
    print('${_model.textController2}');
    print('${_model.empId}');
 
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
    final token = await getAuthToken();
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/hr/api/user_details'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _employeeNameController.text = '${data['first_name']} ${data['last_name']}';
          _employeeIdController.text = data['emp_id'];
          _emailController.text = data['email'];
          _departmentController.text = data['department'];
        });
      } else {
        print('Failed to fetch user details: ${response.body}');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> editBankAccount(int accountId, Map<String, dynamic> accountData, String s) async {
    final token = await getAuthToken();
    final url = Uri.parse('$apiBaseUrl/hr/api/bank-accounts/$accountId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(accountData);
    print('URL: $url');
    print('Headers: $headers');
    print('Body: $body');

    try {
      final response = await http.put(url, headers: headers, body: body);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bank account updated successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BankDetailsHistoryWidget()),
        );
      } else {
        print('Failed to update bank account. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update bank account.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update bank account.'),
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
          backgroundColor: const Color(0xFF002147),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BankDetailsHistoryWidget()),
              );
            },
          ),
          title: Text(
            'Update Bank Application',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                ),
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.more_vert),
          //     tooltip: 'History',
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => const BankDetailsHistoryWidget(),
          //         ),
          //       );
          //     },
          //   ),
          // ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Align(
                  //     alignment: const AlignmentDirectional(-1, 0),
                  //     child: Padding(
                  //       padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 12, 0.0),
                  //       child: Text(
                  //         'Bank Details Application',
                  //         style: FlutterFlowTheme.of(context).bodyMedium.override(
                  //               fontFamily: 'Poppins',
                  //               letterSpacing: 0,
                  //               fontWeight: FontWeight.bold,
                  //               decoration: TextDecoration.underline,
                  //             ),
                  //       ),
                  //     ),
                  //   ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Employee Name',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 5.0, 12.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 12.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: Icon(Icons.person,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18.0,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
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
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Employee Id',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 5.0, 12.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child:  FaIcon(
                                FontAwesomeIcons.idBadge,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18.0,
                              ), 
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
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
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Email',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 5.0, 12.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.email_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 18.0,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
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
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Business Group ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                               fontSize: 12
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                       0, 5.0, 12.0, 0.0),
                    child: TextFormField(
                      controller: _model.textController1,
                      focusNode: _model.textFieldFocusNode1,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Business Group',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
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
                     validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Business Group is required';
                                  }
                                 
                                  return null;
                                },
                    ),
                  ),
                  

                  //depart
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Department ',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                              fontSize: 12
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 5.0, 12.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 0.0, 12.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.briefcase,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18.0,
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
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
                  
               
                

                Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 4),
                      child: Text(
                        'Bank Name',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Poppins',
                                letterSpacing: 0,
                                fontSize: 12,
                                color: Colors.black
                              ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                            child: Icon(
                              Icons.account_balance,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return DropdownButtonFormField<String>(
                                    value: _selectedbankNameType,
                                    items: _bankNamesType.map((e) => DropdownMenuItem(
                                          child: Text(
                                            e,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          value: e,
                                        )).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedbankNameType = newValue!;
                                      });
                                    },
                                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                                    decoration: InputDecoration(
                                      hintText: 'Bank Name',
                                      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0,
                                          ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                   style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Poppins',
                                        letterSpacing: 0,
                                        fontSize:14,
                                      ),
                                    isExpanded: true, // Ensures the dropdown takes full width
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                 //branch
                 
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Branch',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 5.0, 12.0, 0.0),
                    child: TextFormField(
                      controller: _model.textController2,
                      focusNode: _model.textFieldFocusNode2,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Branch',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.location_on,
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
                          _model.textController2Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 15.0, 0.0, 0.0),
                      child: Text(
                        'IBAN Number',
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 5.0, 12.0, 0.0),
                    child: TextFormField(
                      controller: _model.textController3,
                      focusNode: _model.textFieldFocusNode3,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'IBAN Number',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.account_balance_wallet,
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
                          _model.textController3Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Start Date',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                              fontSize: 12
                            ),
                            
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0, 5.0, 12.0, 0.0),
                    child: TextFormField(
                      controller: _model.textController4,
                      focusNode: _model.textFieldFocusNode4,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'yyyy-mm-dd',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.date_range,
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
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0, 15.0, 0.0, 0.0),
                      child: Text(
                        'Bank Code',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Poppins',
                              letterSpacing: 0.0,
                              fontSize: 12
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      0, 5.0, 12.0, 0.0),
                    child: TextFormField(
                      controller: _model.textController5,
                      focusNode: _model.textFieldFocusNode5,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                        hintText: 'Bank Code',
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
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        prefixIcon: Icon(
                          Icons.password,
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
                          _model.textController5Validator.asValidator(context),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        'Comment',
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
                      controller: _model.textController6,
                      focusNode: _model.textFieldFocusNode6,
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
                          color: FlutterFlowTheme.of(context).secondaryText,
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
                                      textAlign: TextAlign.start,
                      validator:
                          _model.textController6Validator.asValidator(context),
                    ),
                  ),

                    // ),

                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                 child: FFButtonWidget(
                      onPressed: () async {
                        final token = await getAuthToken();
                        final accountId = widget.BankAccount['id']; // Assuming you have access to the contract ID
                        final accountData = {
                            'emp_id': _model.empId,
                            'username': _model.username,
                            'department': _model.department,
                            'email': _model.email,
                            'group': _model.textController1?.text,
                 
                            'bank_name': _selectedbankNameType,
                            'branch':  _model.textController2?.text,
                            'iban_number': _model.textController3?.text,
                            'Bankstart_date': _model.textController4?.text,
                          

                            'bank_code': _model.textController5?.text,
                            'bankaccount_comment': _model.textController6?.text,
                        };
                        
                        final jwtToken = token; // Assuming this retrieves the JWT token
                 
                        try {
                          await editBankAccount(accountId, accountData, jwtToken!);
                          
                          // Navigate to next page if contract is updated successfully
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BankDetailsHistoryWidget(),
                            ),
                          );
                        } catch (e) {
                          print('Error: $e');
                          // Show error pop-up
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text('Failed to update Bank Account. Please try again.'),
                          //     backgroundColor: Colors.red,
                          //   ),
                          // );
                        }
                      },
                      text: 'Update',
                      options: FFButtonOptions(
                         width: 140.0,
                          height: 45.0,
                        padding: EdgeInsetsDirectional.fromSTEB(22, 0, 22, 0),
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
                        borderRadius: BorderRadius.circular(6),
                      ), loadingIndicatorColor: Colors.white,
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
       ),), );
  }
}
