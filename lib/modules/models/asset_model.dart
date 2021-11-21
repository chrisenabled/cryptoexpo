

class Asset {
  final String assetName;
  final String assetTicker;
  final String iconAsset;
  final double currentPrice;
  final double percentage;

  Asset({
    required this.assetName,
    required this.assetTicker,
    required this.iconAsset,
    this.currentPrice = 0.000000,
    this.percentage = 0.00
  });
}