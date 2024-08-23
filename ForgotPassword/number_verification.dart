import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class NumberVerificationWidget extends StatefulWidget {
  final String phoneNumber;
  final String sentOtp;

  const NumberVerificationWidget({
    Key? key,
    required this.phoneNumber,
    required this.sentOtp,
  }) : super(key: key);

  @override
  _NumberVerificationWidgetState createState() =>
      _NumberVerificationWidgetState();
}

class _NumberVerificationWidgetState extends State<NumberVerificationWidget> {
  final TextEditingController _otpController = TextEditingController();
  bool isVerifying = false;

  void verifyOtp() {
    setState(() {
      isVerifying = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isVerifying = false;
      });

      if (_otpController.text == widget.sentOtp) {
        // OTP matched
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified successfully!')),
        );
        // Navigate to the next screen or perform further actions
      } else {
        // OTP did not match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP. Please try again.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).oxfordBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Verify Phone Number',
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: 'Raleway',
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verify Phone Number',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Raleway',
                        color: FlutterFlowTheme.of(context).oxfordBlue,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Enter the OTP sent to ${widget.phoneNumber}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Raleway',
                        color: FlutterFlowTheme.of(context).black,
                        fontSize: 14.0,
                      ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _otpController,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize:14),
                      hintText: 'Enter Your Username',
                                   hintStyle: FlutterFlowTheme.of(context)
                            .labelMedium
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                    ),
                   
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20.0),
                FFButtonWidget(
                  onPressed: isVerifying ? null : verifyOtp,
                  text: isVerifying ? 'Verifying...' : 'Verify OTP',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Colors.black,
                    // ignore: deprecated_member_use_from_same_package
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  loadingIndicatorColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
