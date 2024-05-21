import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../model/crypto_model.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final Dio dio;
  CryptoBloc({required this.dio}) : super(CryptoInitial()) {
    on<FetchCryptoAssets>(_onFetchCryptoAssets);
  }

  void _onFetchCryptoAssets(FetchCryptoAssets event,
      Emitter<CryptoState> emit) async {
    emit(CryptoLoading());

    try {
      final response = await dio.get('https://api.coincap.io/v2/assets',
          queryParameters: {
        'limit': 15,
        'offset': event.start,
      });

      if (response.statusCode == 200) {
        final List<CryptoModel> assets = (response.data['data'] as List)
            .map((json) => CryptoModel.fromJson(json))
            .toList();
        emit(CryptoLoaded(assets: assets));
      } else {
        emit(CryptoError(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CryptoError(message: 'Network error: $e'));
    }
  }
}