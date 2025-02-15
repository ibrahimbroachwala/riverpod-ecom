import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../entities/product.dart';

part 'cart_controller.g.dart';

@Riverpod(keepAlive: true)
class ShoppingCart extends _$ShoppingCart {
  @override
  Set<Product> build() {
    return {};
  }

  Future<void> addToCart(Product product) async {
    state = {...state, product};
  }

  Future<void> removeFromCart(Product product) async {
    state.remove(product);
    state = {...state};
  }

  Future<void> incrementQuantity(Product product) async {
    final stateList = state.toList();
    final index = stateList.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      stateList[index] =
          stateList[index].copyWith(quantity: stateList[index].quantity + 1);
    }
    state = {...stateList};
  }

  Future<void> decrementQuantity(Product product) async {
    final stateList = state.toList();

    final index = stateList.indexWhere((item) => item.id == product.id);
    if (index != -1 && stateList[index].quantity > 1) {
      stateList[index] =
          stateList[index].copyWith(quantity: stateList[index].quantity - 1);
    } else if (index != -1 && stateList[index].quantity == 1) {
      stateList.removeAt(index);
    }
    state = {...stateList};
  }
}

@riverpod
double cartTotal(Ref ref) {
  final productsInCart = ref.watch(shoppingCartProvider);
  final total = productsInCart.fold<double>(
    0,
    (sum, product) => sum + (product.price * product.quantity),
  );
  return total;
}
