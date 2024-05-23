import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_app/consts/app_colors.dart';
import 'package:sample_app/features/products/presentation/products_home/products_controller.dart';

import '../../domaine/add_product_model.dart';
import '../products_home/widgets/button_icon_widget.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_category_drop_down.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/image_picker_grid.dart';

class AddProductView extends HookConsumerWidget {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = useState<List<XFile>>([]);

    Future<void> pickImage() async {
      if (images.value.length >= 4) return;

      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        images.value = [...images.value, pickedFile];
      }
    }

    void removeImage(int index) {
      images.value = List.from(images.value)..removeAt(index);
    }

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final priceController = useTextEditingController();
    final storeNameController = useTextEditingController();
    final category = useState<int>(1);

    submit() {
      ref.read(productsControllerProvider.notifier).addProduct(
            AddProductModel(
              name: nameController.text,
              price: double.parse(priceController.text),
              storeName: storeNameController.text,
              categoryId: category.value,
              imageUrl: images.value.map((e) => e.path).toList(),
            ),
          );
    }

    ref.listen(productsControllerProvider, (prev, next) async {
      if (next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.green,
            content: Text('تمت الاضافة بنجاح'),
          ),
        );

        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: const Text('إضافة منتجات'),
                centerTitle: true,
                leading: ButtonIconWidget(
                    icon: 'assets/back.svg',
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('صورة المنتج',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ImagePickerGrid(
                        images: images.value,
                        removeImage: removeImage,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                          onPressed: pickImage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/white_plus.svg'),
                              const SizedBox(width: 8),
                              const Text('اضغط لاضافة الصور ',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        labelText: 'اسم المنتج',
                        hintText: 'ادخل اسم المنتج',
                        controller: nameController,
                      ),
                      CustomTextFormField(
                        labelText: 'السعر',
                        hintText: 'ادخل السعر',
                        keyboardType: TextInputType.number,
                        controller: priceController,
                      ),
                      CustomTextFormField(
                        labelText: 'اسم المتجر',
                        hintText: 'ادخل اسم المتجر',
                        controller: storeNameController,
                      ),
                      const SizedBox(height: 16),
                      CustomCategoryDropDown(
                        onChanged: (val) {
                          category.value = val!;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        child: const Text(' إضافة المنتج',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (images.value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('يجب اختيار صورة واحدة على الاقل'),
                                ),
                              );
                            } else {
                              submit();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
