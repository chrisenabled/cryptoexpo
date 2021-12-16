
import 'package:cryptoexpo/modules/controllers/coin_controller.dart';
import 'package:cryptoexpo/modules/models/trade_calls_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DerivativeDetail extends StatelessWidget {

  final String coinId;

  const DerivativeDetail({Key? key,
    required this.coinId,
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