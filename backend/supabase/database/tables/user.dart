// import '../database.dart';

// class UserTable extends SupabaseTable<UserRow> {
//   @override
//   String get tableName => 'user';

//   @override
//   UserRow createRow(Map<String, dynamic> data) => UserRow(data);
// }

// class UserRow extends SupabaseDataRow {
//   UserRow(super.data);

//   @override
//   SupabaseTable get table => UserTable();

//   String get id => getField<String>('id')!;
//   set id(String value) => setField<String>('id', value);

//   String? get userName => getField<String>('user_name');
//   set userName(String? value) => setField<String>('user_name', value);

//   String? get email => getField<String>('email');
//   set email(String? value) => setField<String>('email', value);

//   String? get firstName => getField<String>('first_name');
//   set firstName(String? value) => setField<String>('first_name', value);

//   int? get phoneNumber => getField<int>('phoneNumber');
//   set phoneNumber(int? value) => setField<int>('phoneNumber', value);
// }
