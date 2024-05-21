class CryptoModel {
  final String id;
  final String symbol;
  final double priceUsd;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.priceUsd,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      symbol: json['symbol'],
      priceUsd: double.parse(json['priceUsd']),
    );
  }
}