import 'package:ecommerce_app/core/constants/app_colors.dart';
import 'package:ecommerce_app/core/constants/app_images.dart';
import 'package:ecommerce_app/view_model/bottom_bar_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key, required this.barViewModel});

  BottomBarViewModel barViewModel;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: barViewModel.selectedIndex,
      unselectedItemColor: Colors.grey.shade300,
      selectedItemColor: AppColors.primaryColor,
      backgroundColor: AppColors.secondaryColor,
      onTap: barViewModel.tabIndex,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.homeIcon),
          activeIcon: SvgPicture.asset(
            AppImages.homeActiveIcon,
            height: 23,
            color: AppColors.primaryColor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.cartIcon),
          activeIcon: SvgPicture.asset(
            AppImages.cartActiveIcon,
            // height: 27,
            color: AppColors.primaryColor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.favoriteIcon),
          activeIcon: SvgPicture.asset(
            AppImages.favoriteActiveIcon,
            color: AppColors.primaryColor,
          ),
          label: '',
        ),
      ],
    );
  }
}
