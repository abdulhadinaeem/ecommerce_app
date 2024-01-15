import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/provider/cart_screen_provider.dart';
import 'package:ecommerce_app/provider/detail_screen_provider.dart';
import 'package:ecommerce_app/provider/view_all_screen_provider.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DetailScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewAllScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartScreenProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            displayMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            displaySmall: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            bodyLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        onGenerateRoute: AppRoutes.ongenerateRoutes,
        initialRoute: RouteNames.cartScreen,
      ),
    );
  }
}
