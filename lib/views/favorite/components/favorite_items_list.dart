import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteItemList extends StatelessWidget {
  FavoriteItemList(
      {super.key,
      required this.image,
      required this.price,
      required this.title,
      required this.quantity});
  String image;
  String title;
  int quantity;
  int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  image,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            '${price.toString()}\$',
            style: context.textTheme.displaySmall?.copyWith(
              color: AppColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
