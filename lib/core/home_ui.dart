import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:cryptoexpo/core/settings/settings_ui.dart';
import 'package:cryptoexpo/widgets/BullBearIcon.dart';
import 'package:cryptoexpo/widgets/animated_flip_counter.dart';
import 'package:cryptoexpo/widgets/animated_flipper.dart';
import 'package:flutter/material.dart';
import 'package:cryptoexpo/widgets/widgets.dart';
import 'package:get/get.dart';

import 'auth/auth_controller.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.firestoreUser.value!.uid == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text('home.title'.tr),
                actions: [
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.to(SettingsUI());
                      }),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Obx(() => BullBearIcon(
                          isBullRun: controller.admin.value,
                          bgColor: AppThemes.whiteLilac,
                          iconSize: 48.0,
                        )),
                    Avatar(controller.firestoreUser.value!),
                    Obx(() =>
                        AnimatedFlipCounter(
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
                          )
                        )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Text(
                            'home.uidLabel'.tr +
                                ': ' +
                                controller.firestoreUser.value!.uid,
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
                            child: Icon(Icons.add),
                            onPressed: () => controller.toggleAdmin()),
                  ],
                ),
              ),
            ),
    );
  }
}
