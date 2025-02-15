import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'texts.dart';

class AppPrimaryButton extends ConsumerWidget {
  const AppPrimaryButton({
    this.labelColor,
    this.padding,
    super.key,
    this.label,
    this.isLoading = false,
    this.height,
    this.width,
    this.vibrateOnTap = true,
    this.borderRadius,
    this.backgroundColor,
    this.margin,
    this.child,
    this.onTap,
  });

  final String? label;
  final bool isLoading;
  final double? height;
  final double? width;
  final bool vibrateOnTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final Widget? child;
  final Function? onTap;
  final EdgeInsets? padding;
  final Color? labelColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            color: backgroundColor ?? AppColors.primary,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              radius: 120,
              onTap: () {
                onTap?.call();
              },
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: Center(
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : child ??
                          Text(
                            label ?? '',
                            style: AppTextStyles.p1
                                .boldWeight(FontWeight.w800)
                                .colored(labelColor ?? AppColors.white),
                          ),
                ),
              ),
            ),
          )),
    );
  }
}
