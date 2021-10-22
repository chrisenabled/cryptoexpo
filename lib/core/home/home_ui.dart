import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/core/settings/settings_ui.dart';
import 'package:cryptoexpo/widgets/app_buttom_nav.dart';
import 'package:cryptoexpo/widgets/bull_bear_icon.dart';
import 'package:cryptoexpo/widgets/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexpo/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';

class HomeUI extends StatelessWidget {
  final double bottomNavBarHeight = 60;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => controller.firestoreUser.value!.uid == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                    bottomNavigationBar: AppBottomNav(
                        selectedCallback: (int selectedPos) {
                          controller.selectedPos.value = selectedPos;
                          // setSystemUIOverlayStyle(context);
                        }
                    ),
                    appBar: AppBar(
                      title: Text('home.title'.tr),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              Get.to(() => SettingsUI());
                            }),
                      ],
                      // backgroundColor: tabItems[controller.selectedPos.value].circleColor,
                    ),
                    body: Stack(
                      children: <Widget>[
                        Padding(
                          child: Obx(() => BodyContainer(
                                frontPage: _frontPage(controller),
                                selectedPos: controller.selectedPos.value,
                              )),
                          padding: EdgeInsets.only(bottom: bottomNavBarHeight),
                        ),
                      ],
                    )));
  }
}

class BodyContainer extends StatelessWidget {
  BodyContainer(
      {this.color = Colors.white,
      required this.selectedPos,
      required this.frontPage});

  final Color color;
  final int selectedPos;
  final Widget frontPage;

  @override
  Widget build(BuildContext context) {
    String slogan;

    if (selectedPos == 0) {
      return frontPage;
    }

    switch (selectedPos) {
      case 1:
        slogan = "Find, Check, Use";
        break;
      case 2:
        slogan = "Receive, Review, Rip";
        break;
      default:
        slogan = "Noise, Panic, Ignore";
        break;
    }
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          slogan,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
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
