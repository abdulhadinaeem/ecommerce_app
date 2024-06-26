import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/app_text.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/view_model/detail_screen_provider.dart';
import 'package:ecommerce_app/views/cart/components/cart_items_listtile.dart';
import 'package:ecommerce_app/widget/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen(
      {super.key,
      required this.discountPrice,
      required this.image,
      required this.price,
      required this.title,
      required this.discountPercentage,
      required this.favList,
      required this.isCartScreen});
  String image;
  String title;
  int price;
  int discountPrice;
  num discountPercentage;
  Products favList;
  bool isCartScreen;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.primaryColor,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.5,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: context.height * 0.5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            title,
                            style: context.textTheme.displayMedium,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '${discountPercentage.toString()}%Off',
                            style: context.textTheme.displayMedium,
                          ),
                          Text(
                            AppText.description,
                            style: context.textTheme.bodySmall,
                            textAlign: TextAlign.left,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${price.toString()}\$',
                                  style: context.textTheme.displayMedium
                                      ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: AppColors.primaryColor),
                                ),
                                Text(
                                  '${discountPrice.toString()}\$',
                                  style: context.textTheme.displayMedium,
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            height: 60,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minWidth: double.infinity,
                            color: AppColors.primaryColor,
                            onPressed: () {
                              isCartScreen
                                  ? null
                                  : provider.addToCart(context, favList);
                            },
                            child: Text(
                              isCartScreen ? 'Buy Now' : AppText.addToCart,
                              style: context.textTheme.displayMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (context.height * 0.45),
              left: (context.width * 0.64),
              child: GestureDetector(
                onTap: () {
                  provider.addToFavorites(context, favList);
                },
                child: Card(
                  elevation: 1,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.favorite,
                        size: 40, color: provider.changeIconColor(favList)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
