import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../entities/product.dart';
import '../../router/route_names.dart';
import '../../style/app_image.dart';
import '../../style/buttons.dart';
import '../../style/colors.dart';
import '../../style/extensions.dart';
import '../../style/snackbar.dart';
import '../../style/texts.dart';
import '../cart/cart_controller.dart';
import '../products/widgets/product_card_widget.dart';

class ProductDetailsPage extends ConsumerWidget {
  final Product product;

  const ProductDetailsPage({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: AppTextStyles.h3,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          padEnds: false,
                          height: 300,
                          enlargeCenterPage: true,
                          autoPlay: true,
                        ),
                        items: List.generate(
                          4,
                          (index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AppImage.network(
                                product.imageUrls[index],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return const SizedBox(
                                    height: 300,
                                    child: Center(child: Text('Loading..')),
                                  );
                                },
                              ),
                            );
                          },
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: AppTextStyles.h2),
                        Text(product.category.name.toUpperCase(),
                            style: AppTextStyles.label),
                        const SizedBox(height: 8),
                        Text('\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.h2.bold
                                .colored(AppColors.primary)),
                        const SizedBox(height: 16),
                        Text(product.description, style: AppTextStyles.p5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: AppPrimaryButton(
                          onTap: () {
                            showFloatingSnackBar(
                                context, '${product.name} added to cart!');
                            ref.read(shoppingCartProvider).add(product);
                          },
                          label: 'Add to Cart',
                          labelColor: AppColors.white,
                        ),
                      ),
                      Center(
                        child: AppPrimaryButton(
                          backgroundColor: AppColors.lightGray,
                          onTap: () {
                            context.pushNamed(RouteNames.cart);
                          },
                          label: 'Go to Cart',
                          labelColor: AppColors.text,
                        ),
                      ),
                      verticalSpace(8)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
