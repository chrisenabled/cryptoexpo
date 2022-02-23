import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/constants/globals.dart';
import 'package:cryptoexpo/widgets/lottie_buttom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppBottomNav extends StatelessWidget {
  AppBottomNav({
    this.selectedCallback,
    this.controller,
  });

  final Function(int)? selectedCallback;

  final LottieBottomNavigationController? controller;

  static const List<LottieTabItem> tabItems = [
    const LottieTabItem('assets/lottie/signal_on_light.json',
        'assets/lottie/signal_on_dark.json', Globals.bottomNavHome),
    const LottieTabItem('assets/lottie/markets_on_light.json',
        'assets/lottie/markets_on_dark.json', Globals.BottomNavMarkets),
    const LottieTabItem(
        'assets/lottie/discover_on_light.json',
        'assets/lottie/discover_on_dark.json',
        Globals.bottomNavDiscover,
        url: 'https://lottiefiles.com/4581-discovery'
    ),
    const LottieTabItem('assets/lottie/profile_on_light.json',
        'assets/lottie/profile_on_dark.json', Globals.bottomNavAssets),
  ];

  final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(child: Divider()),
      Flexible(
          child: LottieBottomNavigation(
            tabItems: tabItems,
            selectedCallback: selectedCallback,
            controller: controller,
      ))
    ]);
  }
}
