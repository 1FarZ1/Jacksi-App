import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_app/consts/app_colors.dart';

class ImagePickerGrid extends HookWidget {
  const ImagePickerGrid({
    super.key,
    required this.images,
    required this.removeImage,
  });

  final List<XFile> images;
  final Function(int val) removeImage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        if (index < images.length) {
          return Stack(
            children: [
              Image.file(
                File(images[index].path),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => removeImage(index),
                  child: const CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return GestureDetector(
            // onTap: pickImage,
            child: Container(
              color: AppColors.white,
            ),
          );
        }
      },
    );
  }
}
