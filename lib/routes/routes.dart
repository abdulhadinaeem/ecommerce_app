import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/detail_screen.dart';
import 'package:ecommerce_app/screens/view_all_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> ongenerateRoutes(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case RouteNames.cartScreen:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );
      case RouteNames.viewAllScreen:
        return MaterialPageRoute(
          builder: (_) => const ViewAllScreen(),
        );
      case RouteNames.detailScreen:
        DetailScreen argument = settings.arguments as DetailScreen;
        String? image = settings.name;
        return MaterialPageRoute(
          builder: (_) => DetailScreen(
            discountPercentage: argument.discountPercentage,
            discountPrice: argument.discountPrice,
            image: argument.image,
            price: argument.price,
            title: argument.title,
          ),
        );
    }
    return MaterialPageRoute(builder: (_) {
      return const Center(
        child: Text(''),
      );
    });
  }
}
