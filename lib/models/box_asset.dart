class BoxAsset {
  final int id;
  final String asset;
  final int price;
  final bool isPremium;

  const BoxAsset({
    required this.isPremium,
    required this.id,
    required this.asset,
    required this.price,
  });
}