import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Are you sure to remove this item from cart?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                ),
              ),
              TextButton(
                onPressed: onPressed,
                child: const Text(
                  'remove',
                  style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
