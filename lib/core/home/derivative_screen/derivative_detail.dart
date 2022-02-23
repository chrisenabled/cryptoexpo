
import 'package:cryptoexpo/core/home/derivative_screen/derivative_controller.dart';
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/models.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:cryptoexpo/widgets/my_tab_bar.dart';
import 'package:cryptoexpo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DerivativeDetail extends StatelessWidget {

  final String coinId;

  const DerivativeDetail({Key? key,
    required this.coinId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DerivativeController>(
      init: DerivativeController(),
        builder: (controller) {
          return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // segmentedWidget(),
                  SizedBox(height: 5,),
                  MyTabBar(
                    tabs: ['Trade Call', 'Stats'],
                    isCapsuleStyle: true,
                    isScrollable: false,
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Center(child: Text(coinId),),
                      Center(child: Text(coinId),)
                    ]),
                  )
                ],
              )
          );
        }
    );
  }

  Widget segmentedWidget() {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: 'settings.system'.tr),
      MenuOptionsModel(
          key: "light", value: 'settings.light'.tr),
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: SegmentedSelector(
          selectedOption: 'system'.tr,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            // controller.setThemeMode(value);
          },
        ),
      ),
    );
  }

}