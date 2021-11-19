

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

double getPercentageChange(double initial, double current) {
  double end = current > initial ? current : initial;
  double start = current > initial ? initial : current;
  double percentage = double.parse((((end - start) / start)  * 100).toStringAsFixed(2));
  return current > initial ? percentage : -(percentage);
}

int getRandomNumber(int min, int max) {
  final random = new Random();
  return min + random.nextInt(max - min);
}