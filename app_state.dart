
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FFAppState extends ChangeNotifier {
//   static FFAppState _instance = FFAppState._internal();

//   factory FFAppState() {
//     return _instance;
//   }

//   FFAppState._internal();

//   static void reset() {
//     _instance = FFAppState._internal();
//   }

//   late SharedPreferences prefs;
//   String _currentUser = '';
//   String _lastRecordedDate = '';

//   Future<void> initializePersistedState() async {
//     prefs = await SharedPreferences.getInstance();
//     _currentUser = prefs.getString('currentUser') ?? '';
//     await loadUserData(_currentUser);

//     _safeInit(() {
//       _name = prefs.getString('ff_name') ?? _name;
//     });

//     _safeInit(() {
//       _email = prefs.getString('ff_email') ?? _email;
//     });

//     _safeInit(() {
//       _empId = prefs.getString('ff_empId') ?? _empId;
//     });

//     _safeInit(() {
//       _status = prefs.getString('ff_status') ?? _status;
//     });

//     _safeInit(() {
//       _username = prefs.getString('ff_username') ?? _username;
//     });

//     _safeInit(() {
//       _image = prefs.getString('ff_image') ?? _image;
//     });

//     _safeInit(() {
//       _Name = prefs.getString('ff_Name') ?? _Name;
//     });

//     _safeInit(() {
//       _NumLeave = prefs.getString('ff_NumLeave') ?? _NumLeave;
//     });

//     _safeInit(() {
//       _Reason = prefs.getString('ff_Reason') ?? _Reason;
//     });

//     _safeInit(() {
//       _Startdate = prefs.getString('ff_Startdate') ?? _Startdate;
//     });

//     _safeInit(() {
//       _EndDate = prefs.getString('ff_EndDate') ?? _EndDate;
//     });

//     _safeInit(() {
//       _checkInLoading = prefs.getBool('ff_checkInLoading') ?? false;
//     });
//   }

//   Future<void> loadUserData(String username) async {
//     _currentUser = username;
//     await prefs.setString('currentUser', username);

//     _isCheckIn = prefs.getBool('${username}_isCheckIn') ?? false;
//     _checkIn = prefs.getString('${username}_checkIn') ?? '';
//     _lastCheckInTime = prefs.getString('${username}_lastCheckInTime') ?? '';
//     _chekout = prefs.getString('${username}_chekout') ?? '';
//     _workingHours = prefs.getString('${username}_workingHours') ?? '';
//     _lastRecordedDate = prefs.getString('${username}_lastRecordedDate') ?? '';

//     String currentDate = DateTime.now().toLocal().toString().split(' ')[0];
//     if (_lastRecordedDate != currentDate) {
//       _isCheckIn = false;
//       _checkIn = '';
//       _lastCheckInTime = '';
//       _chekout = '';
//       _workingHours = '';
//       _lastRecordedDate = currentDate;
//       await saveUserData();
//     }

//     notifyListeners();
//   }

//   Future<void> saveUserData() async {
//     await prefs.setBool('${_currentUser}_isCheckIn', _isCheckIn);
//     await prefs.setString('${_currentUser}_checkIn', _checkIn);
//     await prefs.setString('${_currentUser}_lastCheckInTime', _lastCheckInTime);
//     await prefs.setString('${_currentUser}_chekout', _chekout);
//     await prefs.setString('${_currentUser}_workingHours', _workingHours);
//     await prefs.setString('${_currentUser}_lastRecordedDate', _lastRecordedDate);
//   }

//   void update(VoidCallback callback) {
//     callback();
//     notifyListeners();
//   }

//   bool _checkInLoading = false;
//   bool get checkInLoading => _checkInLoading;
//   set checkInLoading(bool value) {
//     _checkInLoading = value;
//     prefs.setBool('ff_checkInLoading', value);
//     notifyListeners();
//   }

//   String _token = '';
//   String get token => _token;
//   set token(String value) {
//     _token = value;
//   }

//   String _name = '';
//   String get name => _name;
//   set name(String value) {
//     _name = value;
//     prefs.setString('ff_name', value);
//   }

//   String _image = '';
//   String get image => _image;
//   set image(String value) {
//     _image = value;
//     prefs.setString('ff_image', value);
//   }

//   bool _active = false;
//   bool get active => _active;
//   set active(bool value) {
//     _active = value;
//   }

//   bool _isCheckIn = false;
//   bool get isCheckIn => _isCheckIn;
//   set isCheckIn(bool value) {
//     _isCheckIn = value;
//     saveUserData();
//     notifyListeners();
//   }

//   bool _ischeckout = false;
//   bool get ischeckout => _ischeckout;
//   set ischeckout(bool value) {
//     _ischeckout = value;
//   }

//   String _checkIn = '';
//   String get checkIn => _checkIn;
//   set checkIn(String value) {
//     _checkIn = value;
//     _lastCheckInTime = value;
//     _lastRecordedDate = DateTime.now().toLocal().toString().split(' ')[0];
//     saveUserData();
//     notifyListeners();
//   }

//   String _lastCheckInTime = '';
//   String get lastCheckInTime => _lastCheckInTime;

//   String _chekout = '';
//   String get chekout => _chekout;
//   set chekout(String value) {
//     _chekout = value;
//     saveUserData();
//     notifyListeners();
//   }

//   String _workingHours = '';
//   String get workingHours => _workingHours;
//   set workingHours(String value) {
//     _workingHours = value;
//     saveUserData();
//     notifyListeners();
//   }

//   String _Button = '';
//   String get Button => _Button;
//   set Button(String value) {
//     _Button = value;
//   }

//   Color _color = const Color(0xff7ee514);
//   Color get color => _color;
//   set color(Color value) {
//     _color = value;
//   }

//   Color _color2 = const Color(0xffd90429);
//   Color get color2 => _color2;
//   set color2(Color value) {
//     _color2 = value;
//   }

//   String _checkOut = 'CheckOut';
//   String get checkOut => _checkOut;
//   set checkOut(String value) {
//     _checkOut = value;
//   }

//   String _email = '';
//   String get email => _email;
//   set email(String value) {
//     _email = value;
//     prefs.setString('ff_email', value);
//   }

//   String _empId = '';
//   String get empId => _empId;
//   set empId(String value) {
//     _empId = value;
//     prefs.setString('ff_empId', value);
//   }

//   String _status = '';
//   String get status => _status;
//   set status(String value) {
//     _status = value;
//     prefs.setString('ff_status', value);
//   }

//   String _username = '';
//   String get username => _username;
//   set username(String value) {
//     _username = value;
//     prefs.setString('ff_username', value);
//   }

//   bool _makePhoto = false;
//   bool get makePhoto => _makePhoto;
//   set makePhoto(bool value) {
//     _makePhoto = value;
//   }

//   String _fileBase64 = '';
//   String get fileBase64 => _fileBase64;
//   set fileBase64(String value) {
//     _fileBase64 = value;
//   }

//   String _password = '';
//   String get password => _password;
//   set password(String value) {
//     _password = value;
//   }

//   String _Name = '';
//   String get Name => _Name;
//   set Name(String value) {
//     _Name = value;
//     prefs.setString('ff_Name', value);
//   }

//   String _NumLeave = '';
//   String get NumLeave => _NumLeave;
//   set NumLeave(String value) {
//     _NumLeave = value;
//     prefs.setString('ff_NumLeave', value);
//   }

//   String _Reason = '';
//   String get Reason => _Reason;
//   set Reason(String value) {
//     _Reason = value;
//     prefs.setString('ff_Reason', value);
//   }

//   String _Startdate = '';
//   String get Startdate => _Startdate;
//   set Startdate(String value) {
//     _Startdate = value;
//     prefs.setString('ff_Startdate', value);
//   }

//   String _EndDate = '';
//   String get EndDate => _EndDate;
//   set EndDate(String value) {
//     _EndDate = value;
//     prefs.setString('ff_EndDate', value);
//   }

//   String getDisplayCheckInTime() {
//     if (isCheckIn && chekout.isEmpty) {
//       return lastCheckInTime;
//     } else {
//       return checkIn;
//     }
//   }

//   Future<void> saveState() async {
//     await saveUserData();
//   }

//   Future<void> loadState() async {
//     await initializePersistedState();
//   }
// }

// void _safeInit(Function() initializeField) {
//   try {
//     initializeField();
//   } catch (_) {}
// }

// Future _safeInitAsync(Function() initializeField) async {
//   try {
//     await initializeField();
//   } catch (_) {}
// }

// Color? _colorFromIntValue(int? val) {
//   if (val == null) {
//     return null;
//   }
//   return Color(val);
// }
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class FFAppState extends ChangeNotifier {
// //   static FFAppState _instance = FFAppState._internal();

// //   factory FFAppState() {
// //     return _instance;
// //   }

// //   FFAppState._internal();

// //   static void reset() {
// //     _instance = FFAppState._internal();
// //   }

// //   Future initializePersistedState() async {
// //     prefs = await SharedPreferences.getInstance();
// //     _safeInit(() {
// //       _name = prefs.getString('ff_name') ?? _name;
// //     });
// //     _safeInit(() {
// //       _checkIn = prefs.getString('ff_checkIn') ?? _checkIn;
// //     });
// //     _safeInit(() {
// //       _chekout = prefs.getString('ff_chekout') ?? _chekout;
// //     });
// //     _safeInit(() {
// //       _workingHours = prefs.getString('ff_workingHours') ?? _workingHours;
// //     });
// //     _safeInit(() {
// //       _email = prefs.getString('ff_email') ?? _email;
// //     });
// //     _safeInit(() {
// //       _empId = prefs.getString('ff_empId') ?? _empId;
// //     });
// //     _safeInit(() {
// //       _status = prefs.getString('ff_status') ?? _status;
// //     });
// //     _safeInit(() {
// //       _username = prefs.getString('ff_username') ?? _username;
// //     });
// //     _safeInit(() {
// //       _image = prefs.getString('ff_image') ?? _image;
// //     });
// //     _safeInit(() {
// //       _Name = prefs.getString('ff_Name') ?? _Name;
// //     });
// //     _safeInit(() {
// //       _NumLeave = prefs.getString('ff_NumLeave') ?? _NumLeave;
// //     });
// //     _safeInit(() {
// //       _Reason = prefs.getString('ff_Reason') ?? _Reason;
// //     });
// //     _safeInit(() {
// //       _Startdate = prefs.getString('ff_Startdate') ?? _Startdate;
// //     });
// //     _safeInit(() {
// //       _EndDate = prefs.getString('ff_EndDate') ?? _EndDate;
// //     });

// //   }

// //   void update(VoidCallback callback) {
// //     callback();
// //     notifyListeners();
// //   }

// //   late SharedPreferences prefs;

// //   String _token = '';
// //   String get token => _token;
// //   set token(String value) {
// //     _token = value;
// //   }

// //   String _name = '';
// //   String get name => _name;
// //   set name(String value) {
// //     _name = value;
// //     prefs.setString('ff_name', value);
// //   }


// //   String _image = '';
// //   String get image => _image;
// //   set image(String value) {
// //     _image = value;
// //     prefs.setString('ff_image', value);
// //   }


// //   bool _active = false;
// //   bool get active => _active;
// //   set active(bool value) {
// //     _active = value;
// //   }

// //   bool _isCheckIn = false;
// //   bool get isCheckIn => _isCheckIn;
// //   set isCheckIn(bool value) {
// //     _isCheckIn = value;
// //   }

// //   bool _ischeckout = false;
// //   bool get ischeckout => _ischeckout;
// //   set ischeckout(bool value) {
// //     _ischeckout = value;
// //   }

// //   String _checkIn = '';
// //   String get checkIn => _checkIn;
// //   set checkIn(String value) {
// //     _checkIn = value;
// //     prefs.setString('ff_checkIn', value);
// //   }

// //   String _chekout = '';
// //   String get chekout => _chekout;
// //   set chekout(String value) {
// //     _chekout = value;
// //     prefs.setString('ff_chekout', value);
// //   }

// //   String _workingHours = '';
// //   String get workingHours => _workingHours;
// //   set workingHours(String value) {
// //     _workingHours = value;
// //     prefs.setString('ff_workingHours', value);
// //   }

// //   String _Button = '';
// //   String get Button => _Button;
// //   set Button(String value) {
// //     _Button = value;
// //   }

// //   Color _color = const Color(0xff7ee514);
// //   Color get color => _color;
// //   set color(Color value) {
// //     _color = value;
// //   }

// //   Color _color2 = const Color(0xffd90429);
// //   Color get color2 => _color2;
// //   set color2(Color value) {
// //     _color2 = value;
// //   }

// //   String _checkOut = 'CheckOut';
// //   String get checkOut => _checkOut;
// //   set checkOut(String value) {
// //     _checkOut = value;
// //   }

// //   String _email = '';
// //   String get email => _email;
// //   set email(String value) {
// //     _email = value;
// //     prefs.setString('ff_email', value);
// //   }

// //   String _empId = '';
// //   String get empId => _empId;
// //   set empId(String value) {
// //     _empId = value;
// //     prefs.setString('ff_empId', value);
// //   }

// //   String _status = '';
// //   String get status => _status;
// //   set status(String value) {
// //     _status = value;
// //     prefs.setString('ff_status', value);
// //   }

// //   String _username = '';
// //   String get username => _username;
// //   set username(String value) {
// //     _username = value;
// //     prefs.setString('ff_username', value);
// //   }

// //   bool _makePhoto = false;
// //   bool get makePhoto => _makePhoto;
// //   set makePhoto(bool value) {
// //     _makePhoto = value;
// //   }

// //   String _fileBase64 = '';
// //   String get fileBase64 => _fileBase64;
// //   set fileBase64(String value) {
// //     _fileBase64 = value;
// //   }

// //   String _password = '';
// //   String get password => _password;
// //   set password(String value) {
// //     _password = value;
// //   }


  
// //   String _Name = '';
// //   String get Name => _Name;
// //   set Name(String value) {
// //     _Name = value;
// //     prefs.setString('ff_Name', value);
// //   }

// //   String _NumLeave = '';
// //   String get NumLeave => _NumLeave;
// //   set NumLeave(String value) {
// //     _NumLeave = value;
// //     prefs.setString('ff_NumLeave', value);
// //   }

// //   String _Reason = '';
// //   String get Reason => _Reason;
// //   set Reason(String value) {
// //     _Reason = value;
// //     prefs.setString('ff_Reason', value);
// //   }

// //   String _Startdate = '';
// //   String get Startdate => _Startdate;
// //   set Startdate(String value) {
// //     _Startdate = value;
// //     prefs.setString('ff_Startdate', value);
// //   }

// //   String _EndDate = '';
// //   String get EndDate => _EndDate;
// //   set EndDate(String value) {
// //     _EndDate = value;
// //     prefs.setString('ff_EndDate', value);
// //   }

// // }

// // void _safeInit(Function() initializeField) {
// //   try {
// //     initializeField();
// //   } catch (_) {}
// // }

// // Future _safeInitAsync(Function() initializeField) async {
// //   try {
// //     await initializeField();
// //   } catch (_) {}
// // }

// // Color? _colorFromIntValue(int? val) {
// //   if (val == null) {
// //     return null;
// //   }
// //   return Color(val);
// // }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class FFAppState extends ChangeNotifier {
//   static FFAppState _instance = FFAppState._internal();

//   factory FFAppState() {
//     return _instance;
//   }

//   FFAppState._internal();

//   static void reset() {
//     _instance = FFAppState._internal();
//   }

//   Future initializePersistedState() async {
//     prefs = await SharedPreferences.getInstance();

//     _safeInit(() {
//       _name = prefs.getString('ff_name') ?? _name;
//     });

//     _safeInit(() {
//       _checkIn = prefs.getString('ff_checkIn_time') ?? _checkIn;
//     });

//     _safeInit(() {
//       _lastCheckInTime = prefs.getString('ff_last_checkIn_time') ?? _lastCheckInTime;
//     });

//     _safeInit(() {
//       _chekout = prefs.getString('ff_chekout') ?? _chekout;
//     });

//     _safeInit(() {
//       _workingHours = prefs.getString('ff_workingHours') ?? _workingHours;
//     });

//     _safeInit(() {
//       _email = prefs.getString('ff_email') ?? _email;
//     });

//     _safeInit(() {
//       _empId = prefs.getString('ff_empId') ?? _empId;
//     });

//     _safeInit(() {
//       _status = prefs.getString('ff_status') ?? _status;
//     });

//     _safeInit(() {
//       _username = prefs.getString('ff_username') ?? _username;
//     });

//     _safeInit(() {
//       _image = prefs.getString('ff_image') ?? _image;
//     });

//     _safeInit(() {
//       _Name = prefs.getString('ff_Name') ?? _Name;
//     });

//     _safeInit(() {
//       _NumLeave = prefs.getString('ff_NumLeave') ?? _NumLeave;
//     });

//     _safeInit(() {
//       _Reason = prefs.getString('ff_Reason') ?? _Reason;
//     });

//     _safeInit(() {
//       _Startdate = prefs.getString('ff_Startdate') ?? _Startdate;
//     });

//     _safeInit(() {
//       _EndDate = prefs.getString('ff_EndDate') ?? _EndDate;
//     });

//     _safeInit(() {
//       _isCheckIn = prefs.getBool('isCheckIn') ?? false;
//     });

//      _safeInit(() {
//       _checkInLoading = prefs.getBool('ff_checkInLoading') ?? false;
//     });
//   }

//   void update(VoidCallback callback) {
//     callback();
//     notifyListeners();
//   }

//   late SharedPreferences prefs;
//    bool _checkInLoading = false;
//   bool get checkInLoading => _checkInLoading;

//   String _token = '';
//   String get token => _token;
//   set token(String value) {
//     _token = value;
//   }


//    set checkInLoading(bool value) {
//     _checkInLoading = value;
//     prefs.setBool('ff_checkInLoading', value); // Save to SharedPreferences
//     notifyListeners();
//   }

//   String _name = '';
//   String get name => _name;
//   set name(String value) {
//     _name = value;
//     prefs.setString('ff_name', value);
//   }

//   String _image = '';
//   String get image => _image;
//   set image(String value) {
//     _image = value;
//     prefs.setString('ff_image', value);
//   }

//   bool _active = false;
//   bool get active => _active;
//   set active(bool value) {
//     _active = value;
//   }

//   bool _isCheckIn = false;
//   bool get isCheckIn => _isCheckIn;
//   set isCheckIn(bool value) {
//     _isCheckIn = value;
//     prefs.setBool('isCheckIn', value);
//   }

//   bool _ischeckout = false;
//   bool get ischeckout => _ischeckout;
//   set ischeckout(bool value) {
//     _ischeckout = value;
//   }

//   String _checkIn = '';
//   String get checkIn => _checkIn;
//   set checkIn(String value) {
//     _checkIn = value;
//     prefs.setString('ff_checkIn_time', value);
//     _lastCheckInTime = value;
//     prefs.setString('ff_last_checkIn_time', value);
//   }

//   String _lastCheckInTime = '';
//   String get lastCheckInTime => _lastCheckInTime;

//   String _chekout = '';
//   String get chekout => _chekout;
//   set chekout(String value) {
//     _chekout = value;
//     prefs.setString('ff_chekout', value);
//   }

//   String _workingHours = '';
//   String get workingHours => _workingHours;
//   set workingHours(String value) {
//     _workingHours = value;
//     prefs.setString('ff_workingHours', value);
//   }

//   String _Button = '';
//   String get Button => _Button;
//   set Button(String value) {
//     _Button = value;
//   }

//   Color _color = const Color(0xff7ee514);
//   Color get color => _color;
//   set color(Color value) {
//     _color = value;
//   }

//   Color _color2 = const Color(0xffd90429);
//   Color get color2 => _color2;
//   set color2(Color value) {
//     _color2 = value;
//   }

//   String _checkOut = 'CheckOut';
//   String get checkOut => _checkOut;
//   set checkOut(String value) {
//     _checkOut = value;
//   }

//   String _email = '';
//   String get email => _email;
//   set email(String value) {
//     _email = value;
//     prefs.setString('ff_email', value);
//   }

//   String _empId = '';
//   String get empId => _empId;
//   set empId(String value) {
//     _empId = value;
//     prefs.setString('ff_empId', value);
//   }

//   String _status = '';
//   String get status => _status;
//   set status(String value) {
//     _status = value;
//     prefs.setString('ff_status', value);
//   }

//   String _username = '';
//   String get username => _username;
//   set username(String value) {
//     _username = value;
//     prefs.setString('ff_username', value);
//   }

//   bool _makePhoto = false;
//   bool get makePhoto => _makePhoto;
//   set makePhoto(bool value) {
//     _makePhoto = value;
//   }

//   String _fileBase64 = '';
//   String get fileBase64 => _fileBase64;
//   set fileBase64(String value) {
//     _fileBase64 = value;
//   }

//   String _password = '';
//   String get password => _password;
//   set password(String value) {
//     _password = value;
//   }

//   String _Name = '';
//   String get Name => _Name;
//   set Name(String value) {
//     _Name = value;
//     prefs.setString('ff_Name', value);
//   }

//   String _NumLeave = '';
//   String get NumLeave => _NumLeave;
//   set NumLeave(String value) {
//     _NumLeave = value;
//     prefs.setString('ff_NumLeave', value);
//   }

//   String _Reason = '';
//   String get Reason => _Reason;
//   set Reason(String value) {
//     _Reason = value;
//     prefs.setString('ff_Reason', value);
//   }

//   String _Startdate = '';
//   String get Startdate => _Startdate;
//   set Startdate(String value) {
//     _Startdate = value;
//     prefs.setString('ff_Startdate', value);
//   }

//   String _EndDate = '';
//   String get EndDate => _EndDate;
//   set EndDate(String value) {
//     _EndDate = value;
//     prefs.setString('ff_EndDate', value);
//   }

//   String getDisplayCheckInTime() {
//     if (isCheckIn && chekout.isEmpty) {
//       return lastCheckInTime;
//     } else {
//       return checkIn;
//     }
//   }

//   Future<void> saveState() async {
//     await prefs.setString('ff_checkIn_time', _checkIn);
//     await prefs.setString('ff_last_checkIn_time', _lastCheckInTime);
//     await prefs.setBool('isCheckIn', _isCheckIn);
//     await prefs.setString('ff_chekout', _chekout);
//     await prefs.setString('ff_workingHours', _workingHours);
//   }

//   Future<void> loadState() async {
//     await initializePersistedState();
//   }
// }

// void _safeInit(Function() initializeField) {
//   try {
//     initializeField();
//   } catch (_) {}
// }

// Future _safeInitAsync(Function() initializeField) async {
//   try {
//     await initializeField();
//   } catch (_) {}
// }

// Color? _colorFromIntValue(int? val) {
//   if (val == null) {
//     return null;
//   }
//   return Color(val);
// }




import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  late SharedPreferences prefs;
  String _currentUser = '';

  Future<void> initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString('currentUser') ?? '';
    await loadUserData(_currentUser);

    _safeInit(() {
      _name = prefs.getString('ff_name') ?? _name;
    });

    _safeInit(() {
      _email = prefs.getString('ff_email') ?? _email;
    });

    _safeInit(() {
      _empId = prefs.getString('ff_empId') ?? _empId;
    });

    _safeInit(() {
      _status = prefs.getString('ff_status') ?? _status;
    });

    _safeInit(() {
      _username = prefs.getString('ff_username') ?? _username;
    });

    _safeInit(() {
      _image = prefs.getString('ff_image') ?? _image;
    });

    _safeInit(() {
      _Name = prefs.getString('ff_Name') ?? _Name;
    });

    _safeInit(() {
      _NumLeave = prefs.getString('ff_NumLeave') ?? _NumLeave;
    });

    _safeInit(() {
      _Reason = prefs.getString('ff_Reason') ?? _Reason;
    });

    _safeInit(() {
      _Startdate = prefs.getString('ff_Startdate') ?? _Startdate;
    });

    _safeInit(() {
      _EndDate = prefs.getString('ff_EndDate') ?? _EndDate;
    });

    _safeInit(() {
      _checkInLoading = prefs.getBool('ff_checkInLoading') ?? false;
    });
  }

  Future<void> loadUserData(String username) async {
    _currentUser = username;
    await prefs.setString('currentUser', username);

    _isCheckIn = prefs.getBool('${username}_isCheckIn') ?? false;
    _checkIn = prefs.getString('${username}_checkIn') ?? '';
    _lastCheckInTime = prefs.getString('${username}_lastCheckInTime') ?? '';
    _chekout = prefs.getString('${username}_chekout') ?? '';
    _workingHours = prefs.getString('${username}_workingHours') ?? '';
    
    notifyListeners();
  }

  Future<void> saveUserData() async {
    await prefs.setBool('${_currentUser}_isCheckIn', _isCheckIn);
    await prefs.setString('${_currentUser}_checkIn', _checkIn);
    await prefs.setString('${_currentUser}_lastCheckInTime', _lastCheckInTime);
    await prefs.setString('${_currentUser}_chekout', _chekout);
    await prefs.setString('${_currentUser}_workingHours', _workingHours);
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _checkInLoading = false;
  bool get checkInLoading => _checkInLoading;
  set checkInLoading(bool value) {
    _checkInLoading = value;
    prefs.setBool('ff_checkInLoading', value);
    notifyListeners();
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
  }

  String _name = '';
  String get name => _name;
  set name(String value) {
    _name = value;
    prefs.setString('ff_name', value);
  }

  String _image = '';
  String get image => _image;
  set image(String value) {
    _image = value;
    prefs.setString('ff_image', value);
  }

  bool _active = false;
  bool get active => _active;
  set active(bool value) {
    _active = value;
  }

  bool _isCheckIn = false;
  bool get isCheckIn => _isCheckIn;
  set isCheckIn(bool value) {
    _isCheckIn = value;
    saveUserData();
    notifyListeners();
  }

  bool _ischeckout = false;
  bool get ischeckout => _ischeckout;
  set ischeckout(bool value) {
    _ischeckout = value;
  }

  String _checkIn = '';
  String get checkIn => _checkIn;
  set checkIn(String value) {
    _checkIn = value;
    _lastCheckInTime = value;
    saveUserData();
    notifyListeners();
  }

  String _lastCheckInTime = '';
  String get lastCheckInTime => _lastCheckInTime;

  String _chekout = '';
  String get chekout => _chekout;
  set chekout(String value) {
    _chekout = value;
    saveUserData();
    notifyListeners();
  }

  String _workingHours = '';
  String get workingHours => _workingHours;
  set workingHours(String value) {
    _workingHours = value;
    saveUserData();
    notifyListeners();
  }

  String _Button = '';
  String get Button => _Button;
  set Button(String value) {
    _Button = value;
  }

  Color _color = const Color(0xff7ee514);
  Color get color => _color;
  set color(Color value) {
    _color = value;
  }

  Color _color2 = const Color(0xffd90429);
  Color get color2 => _color2;
  set color2(Color value) {
    _color2 = value;
  }

  String _checkOut = 'CheckOut';
  String get checkOut => _checkOut;
  set checkOut(String value) {
    _checkOut = value;
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    _email = value;
    prefs.setString('ff_email', value);
  }

  String _empId = '';
  String get empId => _empId;
  set empId(String value) {
    _empId = value;
    prefs.setString('ff_empId', value);
  }

  String _status = '';
  String get status => _status;
  set status(String value) {
    _status = value;
    prefs.setString('ff_status', value);
  }

  String _username = '';
  String get username => _username;
  set username(String value) {
    _username = value;
    prefs.setString('ff_username', value);
  }

  bool _makePhoto = false;
  bool get makePhoto => _makePhoto;
  set makePhoto(bool value) {
    _makePhoto = value;
  }

  String _fileBase64 = '';
  String get fileBase64 => _fileBase64;
  set fileBase64(String value) {
    _fileBase64 = value;
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
  }

  String _Name = '';
  String get Name => _Name;
  set Name(String value) {
    _Name = value;
    prefs.setString('ff_Name', value);
  }

  String _NumLeave = '';
  String get NumLeave => _NumLeave;
  set NumLeave(String value) {
    _NumLeave = value;
    prefs.setString('ff_NumLeave', value);
  }

  String _Reason = '';
  String get Reason => _Reason;
  set Reason(String value) {
    _Reason = value;
    prefs.setString('ff_Reason', value);
  }

  String _Startdate = '';
  String get Startdate => _Startdate;
  set Startdate(String value) {
    _Startdate = value;
    prefs.setString('ff_Startdate', value);
  }

  String _EndDate = '';
  String get EndDate => _EndDate;
  set EndDate(String value) {
    _EndDate = value;
    prefs.setString('ff_EndDate', value);
  }

  String getDisplayCheckInTime() {
    if (isCheckIn && chekout.isEmpty) {
      return lastCheckInTime;
    } else {
      return checkIn;
    }
  }

  Future<void> saveState() async {
    await saveUserData();
  }

  Future<void> loadState() async {
    await initializePersistedState();
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

Color? _colorFromIntValue(int? val) {
  if (val == null) {
    return null;
  }
  return Color(val);
}
// _________________________________________________________________________________________________________________________



