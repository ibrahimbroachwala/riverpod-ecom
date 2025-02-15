import 'dart:math';

import '../entities/category.dart';
import '../entities/product.dart';
import 'data_repo.dart';

const int itemsPerPage = 20;

final Map<String, List<String>> productDescriptions = {
  'books': [
    'A thrilling mystery novel with unexpected twists.',
    'An inspiring autobiography of a renowned scientist.',
    'A comprehensive guide to mastering photography.',
    'A heartwarming romance set in the countryside.',
    'A gripping science fiction adventure in space.',
  ],
  'electronics': [
    'High-performance laptop with 16GB RAM and 512GB SSD.',
    'Wireless noise-cancelling headphones for clear sound.',
    'Smartphone with a stunning display and fast processor.',
    'Portable Bluetooth speaker with deep bass.',
    'Advanced DSLR camera with 24MP resolution.',
  ],
  'toys': [
    'Interactive toy robot that dances and sings.',
    'Soft plush teddy bear for kids of all ages.',
    'Educational puzzle game for developing young minds.',
    'Colorful building blocks for creative play.',
    'Fun board game for family and friends.',
  ],
  'home': [
    'Elegant wooden dining table for six people.',
    'Durable stainless steel cookware set, 10 pieces.',
    'Luxurious silk bed sheets for a restful sleep.',
    'Energy-efficient LED desk lamp with adjustable brightness.',
    'Cozy fleece blanket for chilly evenings.',
  ],
  'sports': [
    'High-performance running shoes for marathon training.',
    'Breathable athletic shorts for maximum comfort.',
    'Moisture-wicking workout shirt for intense sessions.',
    'Lightweight sports jacket for outdoor activities.',
    'Durable yoga mat with non-slip surface.',
  ],
  'clothing': [
    'Stylish cotton t-shirt with a modern design.',
    'Comfortable running shoes with excellent grip.',
    'Fashionable leather jacket with a sleek fit.',
    'Classic denim jeans with a timeless look.',
    'Elegant evening gown perfect for formal events.',
  ],
};

class DataApi implements DataRepo {
  @override
  Future<List<Product>> fetchProducts(int? page) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final startIndex = (page ?? 0) * itemsPerPage;

    return List.generate(itemsPerPage, (index) {
      final category = ProductCategory
          .values[Random().nextInt(ProductCategory.values.length - 1)];
      final random = Random().nextInt(4) + 1;
      final id = startIndex + index;

      return Product(
          quantity: 1,
          id: id.toString(),
          name: 'Product $id',
          price: (2 * random).toDouble(),
          description: productDescriptions[category.name]?[random] ?? '',
          imageUrls: [
            'https://picsum.photos/id/1$id/200',
            'https://picsum.photos/id/2$id/200',
            'https://picsum.photos/id/3$id/200',
            'https://picsum.photos/id/4$id/200',
          ],
          category: category);
    });
  }

  @override
  Future<List<Product>> fetchProductsByCategory(
      int? page, String? category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final startIndex = (page ?? 0) * itemsPerPage;

    return List.generate(itemsPerPage, (index) {
      final random = Random().nextInt(4) + 1;
      final id = startIndex + index;
      return Product(
          quantity: 1,
          id: id.toString(),
          name: 'Product $id',
          price: (2 * random).toDouble(),
          description: productDescriptions[category]?[random] ?? '',
          imageUrls: [
            'https://picsum.photos/id/1$id/200',
            'https://picsum.photos/id/2$id/200',
            'https://picsum.photos/id/3$id/200',
            'https://picsum.photos/id/4$id/200',
          ],
          category: ProductCategory.values.firstWhere((c) => c.name == category,
              orElse: () => ProductCategory.values[0]));
    });
  }
}
