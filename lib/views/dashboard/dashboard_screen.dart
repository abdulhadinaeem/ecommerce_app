import 'package:ecommerce_app/view_model/bottom_bar_view_model.dart';
import 'package:ecommerce_app/views/cart/cart_screen.dart';
import 'package:ecommerce_app/views/favorite/favorite_screen.dart';
import 'package:ecommerce_app/views/home/home_screen.dart';
import 'package:ecommerce_app/widget/bottomNavBar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomBarViewModel>(context);
    return Scaffold(
      body: IndexedStack(
        index: provider.selectedIndex,
        children: const [
          HomeScreen(),
          CartScreen(),
          FavoriteScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        barViewModel: provider,
      ),
    );
  }
}
