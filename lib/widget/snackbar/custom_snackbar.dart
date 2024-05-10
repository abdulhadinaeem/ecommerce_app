import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {super.key, required this.title, this.onPressed, this.isUndoButton});
  final String title;
  final void Function()? onPressed;
  final bool? isUndoButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style:
                  const TextStyle(color: AppColors.primaryColor, fontSize: 14),
            ),
            isUndoButton ?? false
                ? const SizedBox.shrink()
                : TextButton(
                    onPressed: onPressed,
                    child: const Text(
                      'Undo',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
