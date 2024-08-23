import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://skubsocgzlsszzteyhiv.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNrdWJzb2Nnemxzc3p6dGV5aGl2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk3Mzc2OTUsImV4cCI6MjAyNTMxMzY5NX0.9L9_9Aym1dBJ1R2Q4TiSkOKTIkM6Qqvzo-uh1Du0Hys';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
