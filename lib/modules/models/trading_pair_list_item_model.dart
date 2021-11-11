

import 'dart:math';

import 'package:cryptoexpo/constants/test_data.dart';
import 'package:cryptoexpo/modules/models/signal_model.dart';
import 'package:flutter/material.dart';

class SignalListItemModel {

  final String signal;

  final Color? signalColor;

  final String pair;

  final Color percentageColor;

  // final List<Signal> signals;
  //
  // final double? percentage;
  //
  // Color get directionColor => signals[0].direction == Direction.UP ?
  //     Colors.green : Colors.red;
  //

  final double startPrice;

  final double currentPrice;

  final int signalFrequency;

  // double get getPercentage =>
  //   double.parse((((currentPrice - startPrice) / startPrice)  * 100).toStringAsFixed(2));

  double get getPercentageChangeProgress => (getPercentage() % 100).abs() == 0?
  (getPercentage().abs() / 100).floor() > 0? 100 : 0
      : double.parse((getPercentage().abs() % 100).toStringAsFixed(2));

  double get percentageChange => double.parse((getPercentage() / 100).toStringAsFixed(1));


  const SignalListItemModel(
      this.pair,
      this.signal,
      this.signalColor,
      this.percentageColor,
      this.startPrice,
      this.currentPrice,
      this.signalFrequency,
      );

  double getPercentage() {
    double end = currentPrice > startPrice ? currentPrice : startPrice;
    double start = currentPrice > startPrice ? startPrice : currentPrice;
    double percentage = double.parse((((end - start) / start)  * 100).toStringAsFixed(2));
    return currentPrice > startPrice ? percentage : -(percentage);
  }
}