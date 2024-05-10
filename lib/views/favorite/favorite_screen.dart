import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/view_model/bottom_bar_view_model.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/views/favorite/components/favorite_items_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CartScreenProvider>(context, listen: false);
    provider.getFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: provider.favoriteList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No item in wishList'),
                  MaterialButton(
                    onPressed: () {
                      final prov = Provider.of<BottomBarViewModel>(context,
                          listen: false);
                      prov.tabIndex(0);
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: AppColors.primaryColor,
                    child: const Text(
                      'Explore items',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: provider.favoriteList.length,
                itemBuilder: (context, index) {
                  return FavoriteItemList(
                    image: provider.favoriteList[index].image ?? "",
                    price: provider.favoriteList[index].price ?? 0,
                    quantity: provider.favoriteList[index].quantity ?? 0,
                    title: provider.favoriteList[index].title ?? '',
                  );
                },
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
              ),
            ),
    );
  }
}
