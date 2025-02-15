import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../entities/category.dart';
import '../../router/route_names.dart';
import '../../services/data_api.dart';
import '../../style/colors.dart';
import '../../style/texts.dart';
import '../cart/cart_controller.dart';
import 'products_provider.dart';
import 'widgets/filter_widget.dart';
import 'widgets/product_card_widget.dart';

class ProductsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: AppTextStyles.h3,
        ),
        actions: const [
          CartBadge(),
        ],
      ),
      body: const Column(
        children: [
          ProductFilterWidget(),
          Expanded(
            child: ProductGrid(),
          ),
        ],
      ),
    );
  }
}

class CartBadge extends StatelessWidget {
  const CartBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final cartItemCount = ref.watch(shoppingCartProvider).length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Badge(
            isLabelVisible: cartItemCount > 0,
            textColor: AppColors.white,
            label: Text(
              cartItemCount.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: child,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            context.pushNamed(RouteNames.cart);
          },
          child: const Icon(Icons.shopping_cart_outlined)),
    );
  }
}

class ProductGrid extends ConsumerWidget {
  const ProductGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.7,
      ),
      itemBuilder: (context, index) {
        final category = ref.watch(selectedCategoryProvider);
        final page = index ~/ itemsPerPage;

        return ref.watch(productsProvider(page, category)).when(
              data: (data) {
                final indexInPage = index % itemsPerPage;
                final product = data[indexInPage];

                return ProductCardWidget(
                  product: product,
                  index: index,
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => Center(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 64,
                    width: 64,
                    child: CircularProgressIndicator(
                      color: AppColors.purple,
                    )),
              ),
            );
      },
    );
  }
}
