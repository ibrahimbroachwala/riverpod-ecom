import 'category.dart';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final ProductCategory category;
  final int quantity;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.category,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        imageUrls: List<String>.from(json['imageUrls']),
        category: ProductCategory.values.firstWhere(
          (element) => element.name == json['category'],
        ),
        quantity: json['quantiy']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrls': imageUrls,
      'category': category.name,
      'quantity': quantity,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    List<String>? imageUrls,
    ProductCategory? category,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, description, price, imageUrls, category, quantity];
}
