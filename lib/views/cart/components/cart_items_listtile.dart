import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/views/productDetails/detail_screen.dart';
import 'package:ecommerce_app/widget/dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartItemsListTile extends StatelessWidget {
  CartItemsListTile(
      {super.key,
      required this.image,
      required this.price,
      required this.title,
      required this.quantity,
      required this.discountPercentage,
      required this.favList,
      required this.discountPrice});
  String image;
  String title;
  int quantity;
  int price, discountPrice;
  double discountPercentage;
  Products favList;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) {
              return CustomDialog(
                onPressed: () {
                  provider.removeFromCart(favList);
                  Navigator.pop(context);
                },
              );
            });
      },
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.detailScreen,
          arguments: DetailScreen(
            discountPercentage: discountPercentage,
            discountPrice: discountPrice,
            image: image,
            price: price,
            title: title,
            favList: favList,
            isCartScreen: true,
          ),
        );
      },
      child: Column(
        children: [
          Card(
            elevation: 2,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
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
      ),
    );
  }
}
