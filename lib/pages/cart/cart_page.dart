import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/product.dart';
import '../../style/app_image.dart';
import '../../style/buttons.dart';
import '../../style/colors.dart';
import '../../style/extensions.dart';
import '../../style/texts.dart';
import 'cart_controller.dart';
import 'widgets/cart_item.dart';

class CartPage extends ConsumerWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(shoppingCartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: AppTextStyles.h3,
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems.toList()[index];
                      return CartItemCard(product: product);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primary.withAlpha(50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cart Total',
                              style: AppTextStyles.p5.bold,
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final cartTotalValue =
                                    ref.watch(cartTotalProvider);
                                return Text(
                                  '\$${cartTotalValue.toStringAsFixed(2)}',
                                  style: AppTextStyles.h3,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(8),
                      const AppPrimaryButton(
                        label: 'Proceed to Checkout',
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
