import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemsListTile extends StatelessWidget {
  CartItemsListTile(
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
    return Column(
      children: [
        Card(
          elevation: 2,
          shape: const ContinuousRectangleBorder(),
          margin: const EdgeInsets.only(top: 10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                image,
              ),
            ),
            title: Text(
              title,
              style: context.textTheme.bodyLarge,
            ),
            subtitle: Text(
              quantity.toString(),
              style: context.textTheme.bodyMedium,
            ),
            trailing: Text(
              price.toString(),
              style: context.textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
