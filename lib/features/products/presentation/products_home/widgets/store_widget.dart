import 'package:flutter/material.dart';

import '../../../../../core/consts/app_colors.dart';

class StoreWidget extends StatelessWidget {
  const StoreWidget({super.key, required this.storeName});
  final String storeName;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
            color: AppColors.lowGrey, borderRadius: BorderRadius.circular(8)),
        child: Text(
          storeName,
          style: const TextStyle(
              fontSize: 8, fontWeight: FontWeight.w400, color: AppColors.grey),
        ));
  }
}
