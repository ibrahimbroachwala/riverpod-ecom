import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/category.dart';
import '../../../style/colors.dart';
import '../../../style/texts.dart';
import '../products_provider.dart';

class ProductFilterWidget extends ConsumerWidget {
  const ProductFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Filter by Category',
              style: AppTextStyles.p6,
            ),
          ),
          DropdownButtonHideUnderline(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkerGray.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: ref.watch(selectedCategoryProvider),
                hint: const Text('Filter by Category'),
                onChanged: (value) {
                  ref.read(selectedCategoryProvider.notifier).filterCategory =
                      value;
                },
                icon: const Icon(Icons.filter_alt_outlined),
                borderRadius: BorderRadius.circular(12),
                dropdownColor: AppColors.white,
                items: List.generate(ProductCategory.values.length,
                        (index) => ProductCategory.values[index].name)
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.toUpperCase(),
                            style: AppTextStyles.p4.bold,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
