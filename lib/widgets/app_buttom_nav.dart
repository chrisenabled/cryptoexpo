import 'package:cryptoexpo/config/themes/theme_controller.dart';
import 'package:cryptoexpo/widgets/lottie_buttom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppBottomNav extends StatelessWidget {
  AppBottomNav({required this.selectedCallback});

  final Function(int) selectedCallback;

  static const List<LottieTabItem> tabItems = [
    const LottieTabItem('assets/lottie/signal_on_light.json',
        'assets/lottie/signal_on_dark.json', "Signals"),
    const LottieTabItem('assets/lottie/markets_on_light.json',
        'assets/lottie/markets_on_dark.json', "Markets"),
    const LottieTabItem(
        'assets/lottie/trading.json', 'assets/lottie/trading.json', "Spot"),
    const LottieTabItem('assets/lottie/profile_on_light.json',
        'assets/lottie/profile_on_dark.json', "Assets"),
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
      ))
    ]);
  }
}
