abstract class CryptoEvent {}

class FetchCryptoAssets extends CryptoEvent {
  final int start;
  FetchCryptoAssets({required this.start});
}