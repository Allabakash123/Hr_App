// // ignore_for_file: unnecessary_getters_setters

// import '/backend/schema/util/schema_util.dart';

// import 'index.dart';
// import '/flutter_flow/flutter_flow_util.dart';

// class UserStruct extends BaseStruct {
//   UserStruct({
//     String? uid,
//     String? displayName,
//     String? createTime,
//     String? firstName,
//   })  : _uid = uid,
//         _displayName = displayName,
//         _createTime = createTime,
//         _firstName = firstName;

//   // "uid" field.
//   String? _uid;
//   String get uid => _uid ?? '';
//   set uid(String? val) => _uid = val;
//   bool hasUid() => _uid != null;

//   // "display_name" field.
//   String? _displayName;
//   String get displayName => _displayName ?? '';
//   set displayName(String? val) => _displayName = val;
//   bool hasDisplayName() => _displayName != null;

//   // "create_time" field.
//   String? _createTime;
//   String get createTime => _createTime ?? '';
//   set createTime(String? val) => _createTime = val;
//   bool hasCreateTime() => _createTime != null;

//   // "first_name" field.
//   String? _firstName;
//   String get firstName => _firstName ?? '';
//   set firstName(String? val) => _firstName = val;
//   bool hasFirstName() => _firstName != null;

//   static UserStruct fromMap(Map<String, dynamic> data) => UserStruct(
//         uid: data['uid'] as String?,
//         displayName: data['display_name'] as String?,
//         createTime: data['create_time'] as String?,
//         firstName: data['first_name'] as String?,
//       );

//   static UserStruct? maybeFromMap(dynamic data) =>
//       data is Map ? UserStruct.fromMap(data.cast<String, dynamic>()) : null;

//   Map<String, dynamic> toMap() => {
//         'uid': _uid,
//         'display_name': _displayName,
//         'create_time': _createTime,
//         'first_name': _firstName,
//       }.withoutNulls;

//   @override
//   Map<String, dynamic> toSerializableMap() => {
//         'uid': serializeParam(
//           _uid,
//           ParamType.String,
//         ),
//         'display_name': serializeParam(
//           _displayName,
//           ParamType.String,
//         ),
//         'create_time': serializeParam(
//           _createTime,
//           ParamType.String,
//         ),
//         'first_name': serializeParam(
//           _firstName,
//           ParamType.String,
//         ),
//       }.withoutNulls;

//   static UserStruct fromSerializableMap(Map<String, dynamic> data) =>
//       UserStruct(
//         uid: deserializeParam(
//           data['uid'],
//           ParamType.String,
//           false,
//         ),
//         displayName: deserializeParam(
//           data['display_name'],
//           ParamType.String,
//           false,
//         ),
//         createTime: deserializeParam(
//           data['create_time'],
//           ParamType.String,
//           false,
//         ),
//         firstName: deserializeParam(
//           data['first_name'],
//           ParamType.String,
//           false,
//         ),
//       );

//   @override
//   String toString() => 'UserStruct(${toMap()})';

//   @override
//   bool operator ==(Object other) {
//     return other is UserStruct &&
//         uid == other.uid &&
//         displayName == other.displayName &&
//         createTime == other.createTime &&
//         firstName == other.firstName;
//   }

//   @override
//   int get hashCode =>
//       const ListEquality().hash([uid, displayName, createTime, firstName]);
// }

// UserStruct createUserStruct({
//   String? uid,
//   String? displayName,
//   String? createTime,
//   String? firstName,
// }) =>
//     UserStruct(
//       uid: uid,
//       displayName: displayName,
//       createTime: createTime,
//       firstName: firstName,
//     );
