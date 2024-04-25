import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/app_text.dart';
import 'package:ecommerce_app/view_model/cart_screen_provider.dart';
import 'package:ecommerce_app/views/home/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final providerState =
        Provider.of<CartScreenProvider>(context, listen: false);
    providerState.getGetApiResponce();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      providerState.data = providerState.data;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartScreenProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppText.ourProducts,
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
                                provider.isDescending
                                    ? AppText.decending
                                    : AppText.ascending,
                                style: context.textTheme.displaySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: provider.data.length,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.6),
                        itemBuilder: (context, index) {
                          return ShowProductWidget(
                            discountPrice:
                                provider.data[index].discountedPrice ?? 0,
                            image: provider.data[index].thumbnail ?? '',
                            price: provider.data[index].price ?? 0,
                            title: provider.data[index].title ?? '',
                            discountPercentage:
                                provider.data[index].discountPercentage ?? 0,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
