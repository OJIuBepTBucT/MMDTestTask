import 'package:test_task_mmd/model/crypto_asset.dart';

abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<CryptoAsset> assets;
  CryptoLoaded({required this.assets});
}

class CryptoError extends CryptoState {
  final String message;
  CryptoError({required this.message});
}