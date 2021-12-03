
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetDetail extends StatelessWidget {


  final String coinId;

  const AssetDetail({Key? key,
    required this.coinId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(
        tag: coinId,
        builder: (controller) {
          return Center(
            child: Text(coinId),
          );
        }
    );
  }

}