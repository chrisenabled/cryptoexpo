

import 'dart:math';

import 'package:cryptoexpo/config/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<String?> myLoadAsset(String path) async {
  try {
    return await rootBundle.loadString(path);
  } catch(_) {
    return null;
  }
}

int getRandomNum(int min, int max) {
  return min + new Random().nextInt((max + 1) - min);
}

extension myNumExtension on num {
  num toDecimalNumber(int decimal) {
    return num.parse(this.toStringAsFixed(decimal));
  }
}

T? getTypeFromJson<T>(dynamic _json) {
  if(_json is List) {
    print('$_json');
  }
  if(_json is T) return _json;

  return null;
}

Color getTrendColor(num value, BuildContext context) {
  return value > 0
      ? MyColors.upTrendColor
      : value == 0
      ? Theme.of(context).colorScheme.onPrimary
      : MyColors.downTrendColor;
}
