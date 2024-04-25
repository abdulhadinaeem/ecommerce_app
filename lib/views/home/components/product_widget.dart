import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/views/prodDetails/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShowProductWidget extends StatelessWidget {
  ShowProductWidget(
      {super.key,
      required this.discountPrice,
      required this.image,
      required this.price,
      required this.title,
      required this.discountPercentage});
  String image;
  String title;
  int price;
  int discountPrice;
  num discountPercentage;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.pushNamed(
          context,
          RouteNames.detailScreen,
          arguments: DetailScreen(
            discountPercentage: discountPercentage,
            discountPrice: discountPrice,
            image: image,
            price: price,
            title: title,
          ),
        ).then((value) {
          provider.searchController.clear();
          provider.unSelectSearch();

          provider.resetList();
        });
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
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
                  price.toString(),
                  style: context.textTheme.displaySmall?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${discountPercentage.toString()}%Off',
                  style: context.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
