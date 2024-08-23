import 'dart:convert';

import 'package:team_c/utils/const_api.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class LoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
"username":"$username" ,
"password":"$password" 
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '$apiBaseUrl/api/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.username''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.first_name''',
      ));
  static String? jwt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
}


class LoginFaceCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? image = '',
  }) async {
    final ffApiRequestBody = '''
{
"username":"$username" ,
"password":"$image" 
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '$apiBaseUrl/hr/api/loginFace',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.username''',
      ));
  
  static String? jwt(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.token''',
      ));
}






class LogoutCall {
  static Future<ApiCallResponse> call({
    String? jwt = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'checkin',
      apiUrl: '$apiBaseUrl/hr/api/logout',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}


class CheckinCall {
  static Future<ApiCallResponse> call({
    String? imageData = '',
    String? jwt = '',
    
  }) async {
   final ffApiRequestBody = '{"image_data":"$imageData"}';

    print('API Request Body: $ffApiRequestBody');

    return ApiManager.instance.makeApiCall(
      callName: 'checkin',
      apiUrl: '$apiBaseUrl/hr/api/attendance/checkin',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? checkin(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.check_in_time''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static String? errorMessage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
}


class CheckoutCall {
  static Future<ApiCallResponse> call({
    String? jwt2 = '',
    String? imageData = '',
  }) async {
    final ffApiRequestBody = '{"image_data":"$imageData"}';

    print('API Request Body: $ffApiRequestBody');
    return ApiManager.instance.makeApiCall(
      callName: 'checkout',
      apiUrl: '$apiBaseUrl/hr/api/attendance/checkout',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt2',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? checkouttime(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.checkout_time''',
      ));
  static String? totalhours(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.total_hours''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static String? workingHours(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.working_hours''',
      ));
}

class UserDetailsCall {
  static Future<ApiCallResponse> call({
    String? jwt3 = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UserDetails',
      apiUrl: '$apiBaseUrl/hr/api/user-details',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt3',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.username''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_image''',
      ));
  // static String? empId(dynamic response) => castToType<String>(getJsonField(
  //       response,
  //       r'''$.empId''',
  //     ));
  // static bool? isactive(dynamic response) => castToType<bool>(getJsonField(
  //       response,
  //       r'''$.is_active''',
  //     ));
}

class SignupCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
    String? email = '',
    String? empId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "email": "$email",
  "password": "$password",  
  "empId": "$empId"
 
}
''';
    return ApiManager.instance.makeApiCall(
      callName: 'signup',
      apiUrl: 'https://attendancehr.onrender.com/api/signup',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}




class RegisterCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
    String? imageData = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "email": "<email>",
  "password": "$password",
  "empId": "<empId>",
  "image_data": "$imageData"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'register',
      apiUrl: '$apiBaseUrl/hr/api/register',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}


class LeaveApplicationCall {
  static Future<ApiCallResponse> call({
    String? jwt = '',
    String? name = '',
    String? email = '',
    String? startDate = '',
    String? endDate = '',
    String? reason = '',
    String? leaveType = '',
  }) async {
    final ffApiRequestBody = '''
{
  "name": "$name",
  "email": "$email",
  "start_date": "$startDate",
  "end_date": "$endDate",
  "reason": "$reason",
  "leave_type": "$leaveType"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'leaveApplication',
      apiUrl: '$apiBaseUrl/hr/api/leave-applications',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}


class MedicalReimburseCall {
  static Future<ApiCallResponse> call({
    String? jwt = '',
    String? name = '',
    String? empId = '',
    String? email = '',
    String? group = '',
    String? department = '',
    String? amount = '',
    String? reason = '',
    String? claim = '',
    String? comment = '',
  }) async {
    final ffApiRequestBody = '''
{
  "employee_name": "$name",
  "emp_id":"$empId",
  "email": "$email",
  "business_group":"$group",
  "department": "$department",
  "reason": "$reason",
  "amount_aed": "$amount",
  "type_of_claim": "$claim",
  "reason": "$reason",
  "comments": "$comment"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'leaveApplication',
      apiUrl: '$apiBaseUrl/hr/api/medical-reimbursement',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
  
}




class HistoryBalanceCall {
  static Future<ApiCallResponse> call({
    String? jwt = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'HistoryBalance',
      apiUrl: '$apiBaseUrl/hr/api/leave-data',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
   static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  static String? reason(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.reason''',
      ));    
  static String? duration(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.duration''',
      ));
  static String? startDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.start_date''',
      ));
  
  static String? endDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.end_date''',
      ));
}






class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
