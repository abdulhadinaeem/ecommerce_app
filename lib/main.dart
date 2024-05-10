import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/app_text.dart';
import 'package:ecommerce_app/core/constants/route_names.dart';
import 'package:ecommerce_app/model/favorite_items_model.dart';
import 'package:ecommerce_app/model/products_model.dart';
import 'package:ecommerce_app/view_model/bottom_bar_view_model.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/view_model/detail_screen_provider.dart';
import 'package:ecommerce_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.secondaryColor));
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteItemsModelAdapter());
  Hive.registerAdapter(ProductsAdapter());
  await Hive.openBox<FavoriteItemsModel>(AppText.favoriteItemsBox);
  await Hive.openBox<Products>(AppText.cartProductsBox);

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
          create: (context) => CartScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomBarViewModel(),
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
        initialRoute: RouteNames.dashboardScreen,
      ),
    );
  }
}
