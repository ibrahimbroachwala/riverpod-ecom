import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../entities/product.dart';
import '../../services/data_repo.dart';

part 'products_provider.g.dart';

@riverpod
class SelectedCategory extends _$SelectedCategory {
  @override
  String build() {
    return 'all';
  }

  set filterCategory(String? category) {
    state = category ?? 'all';
  }
}

@riverpod
FutureOr<List<Product>> products(
  Ref ref,
  int page,
  String? category,
) async {
  final dataService = ref.watch(dataServiceProvider);
  var products = <Product>[];

  if (category == 'all') {
    products = await dataService.fetchProducts(page);
  } else {
    products = await dataService.fetchProductsByCategory(page, category);
  }

  return products;
}

// class ProductsNotifier extends StateNotifier<List<Product>> {
//   ProductsNotifier() : super([]);

//   int _page = 0;
//   bool _isLoading = false;

//   Future<void> loadMoreProducts() async {
//     if (_isLoading) return;
//     _isLoading = true;

//     // Simulate network request
//     await Future.delayed(const Duration(seconds: 2));
//     final newProducts = List<Product>.generate(
//         20,
//         (index) =>
//             Product('Product ${_page * 20 + index}', 'Category ${index % 5}'));
//     state = [...state, ...newProducts];
//     _page++;
//     _isLoading = false;
//   }

//   void filterProducts(String? category) {
//     // Implement filtering logic here
//     // For simplicity, we are not filtering in this example
//   }
// }
