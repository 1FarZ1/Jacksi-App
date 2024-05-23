import 'package:flutter/material.dart';
import 'package:sample_app/consts/app_colors.dart';
import 'package:sample_app/utils/validators.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?) validator;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.validator = Validators.nonEmptyValidator,
    this.labelStyle,
    this.hintStyle,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: labelStyle ??
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ?? const TextStyle(color: AppColors.grey),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
