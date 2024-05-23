import 'package:flutter/material.dart';

import '../../../../consts/app_colors.dart';
import '../products_view.dart';

class ChangeViewWidget extends StatelessWidget {
  const ChangeViewWidget({
    super.key,
    required this.viewStyle,
    required this.onTap,
  });

  final ViewStyle viewStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(viewStyle == ViewStyle.list ? Icons.list : Icons.grid_view,
                color: AppColors.red),
            const SizedBox(width: 4),
            Text(
              viewStyle == ViewStyle.list
                  ? 'تغيير عرض المنتجات الى افقي'
                  : 'تغيير عرض المنتجات الى عمودي',
              style: const TextStyle(color: AppColors.red, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
