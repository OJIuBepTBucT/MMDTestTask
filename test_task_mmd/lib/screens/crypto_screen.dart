import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/crypto_bloc.dart';
import '../bloc/crypto_event.dart';
import '../bloc/crypto_state.dart';
import '../model/crypto_model.dart';
import '../widgets/crypto_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});
  @override
  CryptoScreenState createState() => CryptoScreenState();
}

class CryptoScreenState extends State<CryptoScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<CryptoModel> _cryptoAssets = [];
  bool _isFetching = false; // Track if data is being fetched
  bool _hasMoreData = true; // Track if there are more data to fetch
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchCryptoAssets();
  }

  void _fetchCryptoAssets() {
    if (_isFetching || !_hasMoreData) return;
    setState(() {
      _isFetching = true;
    });

    BlocProvider.of<CryptoBloc>(context).add(FetchCryptoAssets(start: _offset));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent -
            MediaQuery.of(context).size.height / 2 && !_isFetching) {
      _offset += 15;
      _fetchCryptoAssets();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CryptoBloc, CryptoState>(
          listener: (context, state) {
            if (state is CryptoLoaded) {

              setState(() {
                if (state.assets.isEmpty) {
                  _hasMoreData = false; // No more data to load
                } else {
                  _cryptoAssets.addAll(state.assets);
                }
                _isFetching = false;
              });

            } else if (state is CryptoError) {

              setState(() {
                _isFetching = false;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is CryptoInitial && _cryptoAssets.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: _cryptoAssets.length + (_isFetching ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _cryptoAssets.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CryptoItem(asset: _cryptoAssets[index], index: index);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}