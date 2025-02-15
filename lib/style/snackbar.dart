import 'package:flutter/material.dart';

import 'colors.dart';
import 'texts.dart';

void showFloatingSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: AppTextStyles.p3.colored(AppColors.white),
    ),
    closeIconColor: AppColors.black,
    backgroundColor: Colors.green[500],
    behavior: SnackBarBehavior.floating,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 172),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
