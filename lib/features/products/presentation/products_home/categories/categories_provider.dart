
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domaine/category.dart';

final currentCategoryProvider = StateProvider<int>((ref) => 0);

final categoriesProvider = Provider<List<Category>>((ref) {
  const thirdimage =
      'https://images.unsplash.com/photo-1429087969512-1e85aab2683d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  return [
    const Category(
      id: 0,
      name: ' عرض الكل ',
      imageUrl:
          'https://images.unsplash.com/photo-1527195612250-460488c1ad32?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    const Category(
      id: 1,
      name: ' تصنيف 1',
      imageUrl:
          'https://images.unsplash.com/photo-1527195612250-460488c1ad32?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    const Category(
      id: 2,
      name: 'تصنيف 2',
      imageUrl:
          'https://images.unsplash.com/photo-1518972734183-c5b490a7c637?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    const Category(
      id: 3,
      name: 'تصنيف 3',
      imageUrl: thirdimage,
    ),
  ];
});