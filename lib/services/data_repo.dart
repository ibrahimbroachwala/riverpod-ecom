import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/product.dart';
import 'data_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_repo.g.dart';

@riverpod
DataRepo dataService(Ref ref) {
  return DataApi();
}

abstract class DataRepo {
  Future<List<Product>> fetchProducts(int? page);

  Future<List<Product>> fetchProductsByCategory(int page, String? category);
}
