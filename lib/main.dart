import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app/app.dart';
import 'package:sample_app/features/products/data/data_source/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(pref),
  ], child: const TaskApp()));
}
