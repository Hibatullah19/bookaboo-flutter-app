import 'package:supabase_flutter/supabase_flutter.dart';

/// Connection details for the BookaBoo Supabase project.
///
/// Both values are safe to ship in the client: the publishable key only ever
/// grants what Row Level Security allows. Override them at build time with
/// `--dart-define=SUPABASE_URL=... --dart-define=SUPABASE_PUBLISHABLE_KEY=...`
/// when pointing the app at a different project.
abstract class SupabaseConfig {
  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://nyjsgfpnikerksllrdda.supabase.co',
  );

  static const publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
    defaultValue: 'sb_publishable_6jV9HZyjtnLRdLAJrAEzSA_oQmwxwxa',
  );

  /// Must be awaited once, before `runApp`.
  static Future<void> initialize() async {
    await Supabase.initialize(url: url, publishableKey: publishableKey);
  }
}

/// The shared client. Only data-layer classes should reach for this.
SupabaseClient get supabase => Supabase.instance.client;
