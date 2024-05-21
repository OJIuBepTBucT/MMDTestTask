class CryptoAsset {
  final String id;
  final String symbol;
  final double priceUsd;

  CryptoAsset({
    required this.id,
    required this.symbol,
    required this.priceUsd,
  });

  factory CryptoAsset.fromJson(Map<String, dynamic> json) {
    return CryptoAsset(
      id: json['id'],
      symbol: json['symbol'],
      priceUsd: double.parse(json['priceUsd']),
    );
  }
}