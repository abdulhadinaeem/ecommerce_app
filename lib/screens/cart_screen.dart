import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/provider/cart_screen_provider.dart';
import 'package:ecommerce_app/widget/cart_items_listtile.dart';
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
    Provider.of<CartScreenProvider>(context, listen: false).getGetApiResponce();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "My Cart",
          style: context.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushNamed(
                  context,
                  RouteNames.viewAllScreen,
                );
              });
            },
            icon: Text(
              "View All",
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 80),
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: provider.data.length,
                    itemBuilder: ((context, index) {
                      return CartItemsListTile(
                        image: provider.data[index].thumbnail ?? '',
                        price: provider.data[index].price ?? 0,
                        title: provider.data[index].title ?? '',
                        quantity: provider.data[index].quantity ?? 0,
                      );
                    }),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                              'Check Out',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
