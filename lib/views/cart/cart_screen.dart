import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/app_text.dart';
import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/views/cart/components/cart_items_listtile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Provider.of<CartScreenProvider>(context, listen: false).getCartItemsList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          AppText.myCart,
          style: context.textTheme.displayLarge,
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 80),
            width: double.infinity,
            child: ListView.builder(
              itemCount: provider.cartItemsList.length,
              itemBuilder: ((context, index) {
                return CartItemsListTile(
                  image: provider.cartItemsList[index].thumbnail ?? '',
                  price: provider.cartItemsList[index].price ?? 0,
                  title: provider.cartItemsList[index].title ?? '',
                  quantity: provider.cartItemsList[index].quantity ?? 0,
                  discountPercentage:
                      provider.cartItemsList[index].discountPercentage ?? 0,
                  discountPrice:
                      provider.cartItemsList[index].discountedPrice ?? 0,
                  favList: provider.cartItemsList[index],
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${provider.totalAmmount.toString()}',
                    style: context.textTheme.displayLarge),
                MaterialButton(
                  height: 40,
                  color: AppColors.primaryColor,
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.shopping_cart_checkout_sharp,
                        color: Colors.white,
                      ),
                      Text(
                        AppText.checkOut,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
