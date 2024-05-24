import 'package:flutter_riverpod/flutter_riverpod.dart';

final boxProvider = Provider<HiveManager>(
    (ref) => HiveManager()
    );


class HiveManager {
  // Your code here
  dynamic getData(String key) {
    // Your code here
  }
  void saveData(String key, dynamic value) {
    // Your code here
  }
}