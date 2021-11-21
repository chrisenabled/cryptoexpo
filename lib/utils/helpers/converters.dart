

import 'dart:math';
import 'dart:ui';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

num getPercentageDiff({required num initial, required num current}) {
  if(initial <= 0 || current <= 0) {
    return 0.0;
  }
  num end = current > initial ? current : initial;
  num start = current > initial ? initial : current;
  num percentage = double.parse((((end - start) / start)  * 100).toStringAsFixed(2));
  return current >= initial ? percentage : -(percentage);
}

num  getPercentageChangeProgress ({required num percentage}) {
  return (percentage % 100).abs() == 0
      ? (percentage.abs() / 100).floor() > 0
      ? 100
      : 0
      : double.parse((percentage.abs() % 100).toStringAsFixed(2));
}

int getRandomNumber(int min, int max, {bool includeMax: false}) {
  final random = new Random();
  final int diff = !includeMax? max - min : (max - min) + 1;
  return min + random.nextInt(diff);
}