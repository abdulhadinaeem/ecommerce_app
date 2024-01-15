import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/provider/cart_screen_provider.dart';
import 'package:ecommerce_app/widget/show_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  void initState() {
    final providerState =
        Provider.of<CartScreenProvider>(context, listen: false);

    providerState.addProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: provider.isSearching ? false : true,
        title: provider.isSearching
            ? TextField(
                onChanged: (value) {
                  provider.runFilter(value);
                },
                controller: provider.searchController,
              )
            : const Text(""),
        actions: [
          IconButton(
            onPressed: provider.checkIsSearching,
            icon: const Icon(
              Icons.search,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Our Products",
                  style: context.textTheme.displayLarge,
                ),
                TextButton(
                  onPressed: provider.checkIsDescending,
                  child: Row(
                    children: [
                      const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.compare_arrows,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        provider.isDescending ? "Decending" : "Ascending",
                        style: context.textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: provider.foundUser.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    return ShowProductWidget(
                      discountPrice:
                          provider.foundUser[index].discountedPrice ?? 0,
                      image: provider.foundUser[index].thumbnail ?? '',
                      price: provider.foundUser[index].price ?? 0,
                      title: provider.foundUser[index].title ?? '',
                      discountPercentage:
                          provider.foundUser[index].discountPercentage ?? 0,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
