import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../model/crypto_asset.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final Dio dio;
  CryptoBloc({required this.dio}) : super(CryptoInitial()) {
    on<FetchCryptoAssets>(_onFetchCryptoAssets);
  }

  void _onFetchCryptoAssets(FetchCryptoAssets event, Emitter<CryptoState> emit)
  async {
    emit(CryptoLoading());
    try {
      final response = await dio.get('https://api.coincap.io/v2/assets',
          queryParameters: {
        'limit': 15,
        'offset': event.start,
      });
      final List<CryptoAsset> assets = (response.data['data'] as List)
          .map((json) => CryptoAsset.fromJson(json))
          .toList();
      emit(CryptoLoaded(assets: assets));
    } catch (e) {
      emit(CryptoError(message: e.toString()));
    }
  }
}