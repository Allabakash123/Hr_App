

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_c/employepage/employepage_widget.dart';
import 'package:team_c/utils/const_api.dart';
import 'package:team_c/utils/constants/sizes.dart';
import 'package:team_c/visiting_card/visiting_card_model.dart';
import 'package:team_c/visiting_card/visiting_card_update.dart';
import 'package:url_launcher/url_launcher.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


class CardviisitWidget extends StatefulWidget {
  const CardviisitWidget({super.key});

  @override
  State<CardviisitWidget> createState() => _CardviisitWidgetState();
}

class _CardviisitWidgetState extends State<CardviisitWidget> {
  
  static const platform = MethodChannel('com.yourcompany.app/share');// Define the MethodChannel here

  String? vcfFilePath;
  String? _filePath;
  late CardviisitCopyModel _model;
  String? _username;
  String? _email;
  String? _country;
  String? _whatsUpNumber;
  String? _designation;
  String? _poBox;
  String? _unitedState;
  String? _telphone;
  String? _Ext;
  String? _Faxnum;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CardviisitCopyModel());
    _fetchVisitingDetails();

  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

void _openFile() {
    if (vcfFilePath != null) {
      OpenFile.open(vcfFilePath!);
    }
  }

Future<bool> _requestPermission(Permission permission) async {
    print("Requesting storage permission...");
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      var result = await Permission.manageExternalStorage.request();
      print("Permission.manageExternalStorage request result: ${result.isGranted}");
      return result.isGranted;
    } else {
      if (await permission.isGranted) {
        print("Permission already granted.");
        return true;
      } else {
        var result = await permission.request();
        print("Permission request result: ${result.isGranted}");
        return result.isGranted;
      }
    }
  }


Future<void> _fetchVisitingDetails() async {
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
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _username = data['username'].toString();
        _email = data['email'].toString();
        _country = data['Visitingcountry'].toString();
        _whatsUpNumber = data['mobilenum'].toString();
        _designation = data['designation'].toString();
        _poBox = data['poBox'].toString();
        _unitedState = data['unitedstate'].toString();
        _telphone = data['telphone'].toString();
        _Ext = data['extnum'].toString();
        _Faxnum = data['faxnum'].toString();
      });
      print('Visiting details fetched successfully');
    } else {
      print('Failed to fetch user details: ${response.statusCode}');
    }
  }

String _generateVcfContent() {
  return '''BEGIN:VCARD
VERSION:3.0
N:${_username ?? ''};;;;
FN:${_username ?? ''}
ORG:Al Yousuf
TITLE:${_designation ?? ''}
TEL;TYPE=WORK,VOICE:${_telphone ?? ''}
TEL;TYPE=WORK,VOICE:${_Ext ?? ''}
TEL;TYPE=WORK,FAX:${_Faxnum ?? ''}
TEL;TYPE=CELL,VOICE:${_whatsUpNumber ?? ''}
ADR;TYPE=WORK:;;${_poBox ?? ''};${_country ?? ''};${_unitedState ?? ''};;
EMAIL;TYPE=PREF,INTERNET:${_email ?? ''}
URL:www.alyousuf.com
END:VCARD''';
}

Future<void> _downloadVcf() async {
  try {
    print("Generating VCF content...");
    final vcfContent = _generateVcfContent();

    // Get the external storage directory
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw Exception('Unable to access external storage');
    }

    final file = File('${directory.path}/contact.vcf');
    await file.writeAsString(vcfContent, encoding: utf8);
    
    setState(() {
      _filePath = file.path;
    });
    
    print('VCF file saved at: ${file.path}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('VCF file saved successfully')),
    );
  } catch (e) {
    print('Error saving VCF file: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save VCF file: $e')),
    );
  }
}

Future<void> _shareVcfFile() async {
  if (_filePath == null) {
    print("VCF file path is null");
    return;
  }

  try {
    final file = File(_filePath!);
    if (await file.exists()) {
      final uri = Uri.parse('whatsapp://send?text=${Uri.encodeComponent("Here's my contact information")}');
      
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        
        // Give WhatsApp a moment to open
        await Future.delayed(Duration(seconds: 1));
        
        // Now share the file using Android's native sharing
        final result = await platform.invokeMethod('shareFile', {'filePath': _filePath});
        print("Share result: $result");
      } else {
        throw 'Could not launch WhatsApp';
      }
    } else {
      throw 'File does not exist';
    }
  } catch (e) {
    print("Error sharing file: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to share VCF file: $e')),
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
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
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
                  MaterialPageRoute(
                      builder: (context) => EmployepageWidget(token: token)),
                );
              }
            },
          ),
          title: Text(
            'Visiting Card',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 0,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                print("Download VCF button pressed.");
                if (await _requestPermission(Permission.storage)) {
                  print("Permission is granted.");
                  await _downloadVcf();
                } else {
                  print("Permission is not granted.");
                }
              },
              icon: const Icon(Icons.download, color: Colors.white),
            ),
             
            IconButton(
              onPressed: () async {
                await _shareVcfFile();
              },
              icon: const Icon(Icons.share, color: Colors.white),
            ),

            IconButton(
              onPressed: () async {
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
                  final Map<String, dynamic> data = jsonDecode(response.body);
                  final int visaId = data['id'];
                  final Map<String, dynamic> visaData =
                      await fetchVisitindData(visaId);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          VistingCardFormUpdateWidget(visitingData: visaData),
                    ),
                  );
                } else {
                  print('Failed to fetch visiting card data');
                }
              },
              icon: const Icon(Icons.edit),
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(5, 20, 5, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
          Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
  child: Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Theme.of(context).secondaryHeaderColor,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/visitingCard1.jpg',
            width: 420,
            height: 250,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom:20.0), // Adjust padding as needed
            child: Text(
              'www.alyousuf.com',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    fontSize: 15,
                    letterSpacing: 0,
                  ),
            ),
          ),
        ),
      ],
    ),
  ),
),
                Center(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(5, 30, 5, 0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Center(
                            child: Image.asset(
                              'assets/images/Presentation3.jpg',
                              width: 450,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, 2.27),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 80, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 7, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 3),
                                        child: Text(
                                          _username ?? '',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 22,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        _designation ?? '',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 140, 0, 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                                Positioned(
                          bottom:
                              16, // Adjust this value to move the QR code up or down
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                              },
                              child: FutureBuilder<Uint8List>(
                                future: _generateQrCode(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  } else {
                                    return Image.memory(
                                      snapshot.data!,
                                      width: 80,
                                      height: 80,
                                    ); // Adjust the size here
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                     
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "P.O. Box ",
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700
                                                ),
                                          ),
                                          Text(
                                            '${_poBox ?? ''},',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            '${_country ?? ''}',
                                           style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                ),
                                          ),
                                          // Text(
                                          //   _unitedState ?? '',
                                          //   style: FlutterFlowTheme.of(context)
                                          //       .bodyMedium
                                          //       .override(
                                          //         fontFamily: 'Readex Pro',
                                          //         fontSize: 12,
                                          //         letterSpacing: 0,
                                          //       ),
                                          // ),
                                        ],
                                      ),
                                    const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Tel: ',
                                             style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700
                                                ),
                                            ),
                                            Text(
                                              '${_telphone ?? ''},',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                  ),
                                            ),

                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'Ext: ',
                                             style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700
                                                ),
                                            ),
                                            Text(
                                              '${_Ext ?? ''},',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                  ),
                                            ),
                                            ],
                                        ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                            Text(
                                              'Fax: ',
                                             style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700
                                                ),
                                            ),
                                            Text(
                                              '${_Faxnum ?? ''},',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                  ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              'Mob: ',
                                              style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w700
                                                ),
                                            ),
                                            Text(
                                              _whatsUpNumber ?? '',
                                              style: FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                  ),
                                            ),
                                            ],),
                                          
                                      
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0, 5, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: Text(
                                                _email ?? '',
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      fontSize: 12,
                                                      letterSpacing: 0,
                                                    ),
                                              ),
                                            ),
                                           
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      
                       
                      ],
                    ),
                  ),
                ),
                if (_filePath != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 10.0),
                     child: RichText(
                       text: const TextSpan(
                         text: 'Note: ',
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.red,
                           fontSize: TSizes.fontSizeMd*1.0,
                         ),
                         children: <TextSpan>[
                           TextSpan(
                             text:
                                 'Click the below card to share(Message).',
                             style: TextStyle(
                               fontWeight: FontWeight.normal,
                               color: Colors.black,
                               fontSize:TSizes.fontSizeSm*0.9,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                  Padding(
  padding: const EdgeInsets.all(8.0),
  child: Card(
    color: Colors.white, // Pure white background
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Border radius of 12
    ),
    child: ListTile(
      leading: const Icon(Icons.file_present),
      title: const Text('contact.vcf'),
      subtitle: const Text('VCF file downloaded'),
      onTap: () {
        if (_filePath != null) {
          print("File tapped for sharing: $_filePath");
          Share.shareFiles([_filePath!], text: 'Here is the contact.vcf file');
        } else {
          print("No file path provided.");
        }
      },
    ),
  ),
)

                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Future<Uint8List> _generateQrCode() async {
    // Generate vCard data
    final String vCardData = '''
BEGIN:VCARD
VERSION:3.0
FN:${_username ?? ''}
TEL;TYPE=CELL:${_whatsUpNumber ?? ''}
EMAIL:${_email ?? ''}
TITLE:${_designation ?? ''}
END:VCARD
''';

    // Generate QR code image data with vCard data
    final qrImageData = await QrPainter(
      data: vCardData,
      version: QrVersions.auto,
      // ignore: deprecated_member_use
      color: Colors.black,
      // ignore: deprecated_member_use
      emptyColor: Colors.white,
    ).toImageData(300);

    // Convert ByteData to List<int>
    return qrImageData!.buffer.asUint8List();
  }
}

Future<String?> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<Map<String, dynamic>> fetchVisitindData(int visaId) async {
  final token = await getAuthToken();

  final String? jwt3 = token;

  final String apiUrl = '$apiBaseUrl/hr/api/visiting-card-get/$visaId';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt3',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch exception data');
  }
}


