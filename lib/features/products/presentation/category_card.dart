import 'package:flutter/material.dart';
import 'package:sample_app/consts/app_colors.dart';
import 'package:sample_app/features/products/presentation/products_view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.category,
      required this.onTap,
      required this.isSelected});
  final Category category;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
          onTap: onTap,
          child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: isSelected ? AppColors.green : AppColors.white)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    category.imageUrl,
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                ],
              ))),
    );
  }
}
