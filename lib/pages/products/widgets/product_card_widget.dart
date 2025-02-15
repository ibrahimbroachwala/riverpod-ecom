import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../entities/product.dart';
import '../../../router/app_router.dart';
import '../../../router/route_names.dart';
import '../../../style/app_image.dart';
import '../../../style/colors.dart';
import '../../../style/texts.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    required this.product,
    required this.index,
    super.key,
  });

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: InkWell(
        onTap: () {
          context.pushNamed(RouteNames.productDetail, extra: product);
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  child: AppImage.network(
                    progressIndicatorBuilder: (context, url, progress) {
                      return const SizedBox(
                        height: 200,
                        child: Center(child: Text('Loading..')),
                      );
                    },
                    product.imageUrls[0],
                  )),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppTextStyles.p1,
                          ),
                          Text(
                            product.category.name.toUpperCase(),
                            style: AppTextStyles.p6
                                .fontS(10)
                                .bold
                                .colored(AppColors.darkerGray),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.p4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
