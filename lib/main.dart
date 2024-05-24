import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_app/app.dart';
import 'package:sample_app/features/products/data/data_source/local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/products/domaine/product/product_model.dart';

enum Boxes {
  products;

  String get name => '${toString().split('.').last}box';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<ProductModel>(Boxes.products.name);

  final pref = await SharedPreferences.getInstance();

  runApp(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(pref),
        hiveProvider.overrideWithValue(Hive.box<ProductModel>(Boxes.products.name)),
      ],
      child:
          DevicePreview(enabled: true, builder: (context) => const TaskApp())));
}
