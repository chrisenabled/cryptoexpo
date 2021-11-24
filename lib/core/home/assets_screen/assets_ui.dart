

import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/widgets/asset_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'assets_controller.dart';

class AssetsUI extends StatelessWidget {

  const AssetsUI();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<AssetsController>(
          init: AssetsController(),
          builder: (controller) => buildAssetList(controller),
        )
      ),
    );
  }

  Widget buildAssetList(AssetsController controller) {
    return ListView(
        children: controller.coinMetas.map((coin) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 15.0),
          child: Column(
            children: [
              AssetListItem(coinMetaData: coin),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(),
              ),
            ],
          ),
        )).toList(),
      );
  }

}