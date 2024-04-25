import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/views/cart/cart_screen.dart';
import 'package:ecommerce_app/views/dashboard/dashboard_screen.dart';
import 'package:ecommerce_app/views/prodDetails/detail_screen.dart';
import 'package:ecommerce_app/views/home/home_screen.dart';
import 'package:ecommerce_app/widget/bottomNavBar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> ongenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.dashboardScreen:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case RouteNames.cartScreen:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case RouteNames.detailScreen:
        DetailScreen argument = settings.arguments as DetailScreen;

        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            discountPercentage: argument.discountPercentage,
            discountPrice: argument.discountPrice,
            image: argument.image,
            price: argument.price,
            title: argument.title,
          ),
        );
      default:
        null;
    }
    return MaterialPageRoute(builder: (_) {
      return const Center(
        child: Text(''),
      );
    });
  }
}
