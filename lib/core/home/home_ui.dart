import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/constants/constants.dart';
import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/core/home/assets_screen/asset_detail.dart';
import 'package:cryptoexpo/core/home/assets_screen/assets_ui.dart';
import 'package:cryptoexpo/core/home/home_controller.dart';
import 'package:cryptoexpo/core/home/markets_screen/markets_ui.dart';
import 'package:cryptoexpo/core/settings/settings_ui.dart';
import 'package:cryptoexpo/utils/helpers/shared_pref.dart';
import 'package:cryptoexpo/widgets/app_buttom_nav.dart';
import 'package:cryptoexpo/widgets/my_tab_bar.dart';
import 'package:cryptoexpo/widgets/signals_tab_bar_view.dart';
import 'package:cryptoexpo/core/home/signals_screen/signals_ui.dart';
import 'package:cryptoexpo/widgets/bull_bear_icon.dart';
import 'package:cryptoexpo/widgets/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexpo/widgets/widgets.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';

class HomeUI extends StatelessWidget {

  final RxBool isBackgroundBar = false.obs;

  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        // builder: (controller) => controller.firestoreUser.value!.uid == null
        builder: (controller) => Scaffold(
            appBar: _buildAppBar(controller.selectedPos.value),
            body: BottomNavViewHolder(
                selectedPos: controller.selectedPos.value,
                views: [
                  const Signals(),
                  const MarketsUI(),
                  AssetDetail(coinId: controller.selectedDerivative!),
                  const AssetsUI(),
                ]
            ),
            bottomNavigationBar:
            AppBottomNav(
              controller: controller.bottomNavigationController,
            )
        )
    );
  }

  PreferredSizeWidget _buildAppBar(int selectedPos) {

    String getTitle() {
      switch(selectedPos) {
        case 0: return 'Signals';
        case 1: return 'Markets';
        case 3: return 'Assets';
        default: return 'Need Title';
      }
    }

    return AppBar(
      title: Text(getTitle()),
      actions: [
        IconButton(
            icon: Icon(Icons.share_arrival_time_outlined),
            onPressed: () {
              isBackgroundBar.toggle();
              SharedPref.getOrSetIsBackGroundBar(
                  isBackgroundBar: isBackgroundBar.value
              );
            }),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(() => SettingsUI());
            }),
      ],
    ); //
  }
}

class BottomNavViewHolder extends StatelessWidget {
  BottomNavViewHolder({required this.selectedPos, required this.views});

  final int selectedPos;
  final List<Widget> views;

  @override
  Widget build(BuildContext context) {
    switch(selectedPos) {
      case 0: return views[0];
      case 1: return views[1];
      case 2: return views[2];
      case 3: return views[3];
      default: return Center(child: Text('This page does not exist'),);
    }
  }
}


Widget _frontPage(AuthController controller) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Obx(() => BullBearIcon(
              isBullRun: controller.admin.value,
              bgColor: AppThemes.whiteLilac,
              iconSize: 48.0,
            )),
        Avatar(controller.firestoreUser.value!),
        Obx(() => AnimatedFlipCounter(
            value: 2000 + controller.counter.value,
            prefix: "Profit ",
            duration: Duration(seconds: 1),
            curve: Curves.bounceOut,
            fractionDigits: 2,
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
              shadows: [
                BoxShadow(
                  color: Colors.green,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ))),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                'home.uidLabel'.tr + ': ' + controller.firestoreUser.value!.uid,
                style: TextStyle(fontSize: 16)),
            Text(
                'home.nameLabel'.tr +
                    ': ' +
                    controller.firestoreUser.value!.name,
                style: TextStyle(fontSize: 16)),
            Text(
                'home.emailLabel'.tr +
                    ': ' +
                    controller.firestoreUser.value!.email,
                style: TextStyle(fontSize: 16)),
            Text(
                'home.adminUserLabel'.tr +
                    ': ' +
                    controller.admin.value.toString(),
                style: TextStyle(fontSize: 16)),
          ],
        ),
        FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => controller.toggleAdmin()),
      ],
    ),
  );
}
