import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/product.dart';
import '../../../style/app_image.dart';
import '../../../style/colors.dart';
import '../../../style/extensions.dart';
import '../../../style/texts.dart';
import '../cart_controller.dart';

class CartItemCard extends ConsumerWidget {
  const CartItemCard({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppImage.network(
              width: 100,
              product.imageUrls[0],
              progressIndicatorBuilder: (context, url, progress) {
                return const SizedBox(
                  height: 100,
                  child: Center(child: Text('Loading..')),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(12),
                Text(
                  product.name,
                  style: AppTextStyles.p1.bold,
                ),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.p4,
                ),
              ],
            ),
          ),
          // Quantity Controls
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      ref
                          .read(shoppingCartProvider.notifier)
                          .decrementQuantity(product);
                    },
                  ),
                  Text(
                    product.quantity.toString(),
                    style: AppTextStyles.p1.bold,
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(12),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      ref
                          .read(shoppingCartProvider.notifier)
                          .incrementQuantity(product);
                    },
                  ),
                ],
              ),
              verticalSpace(8),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  ref
                      .read(shoppingCartProvider.notifier)
                      .removeFromCart(product);
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete_outline_outlined,
                          size: 16,
                          color: AppColors.text,
                        ),
                        horizontalSpace(4),
                        Text(
                          'Remove',
                          style: AppTextStyles.p6,
                        ),
                      ],
                    )),
              ),
              verticalSpace(8)
            ],
          ),
        ],
      ),
    );
  }
}
