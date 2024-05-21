// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/crypto_bloc.dart';
// import '../bloc/crypto_event.dart';
// import '../bloc/crypto_state.dart';
// import '../model/crypto_asset.dart';
// import '../widgets/crypto_item.dart';
//
// class CryptoScreen extends StatefulWidget {
//   @override
//   _CryptoScreenState createState() => _CryptoScreenState();
// }
//
// class _CryptoScreenState extends State<CryptoScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final List<CryptoAsset> _cryptoAssets = [];
//   int _offset = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _fetchCryptoAssets();
//   }
//
//   void _fetchCryptoAssets() {
//     BlocProvider.of<CryptoBloc>(context).add(FetchCryptoAssets(start: _offset));
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       _offset += 15;
//       _fetchCryptoAssets();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 24.0), // Top padding to match Figma design
//         child: BlocBuilder<CryptoBloc, CryptoState>(
//           builder: (context, state) {
//             if (state is CryptoInitial || state is CryptoLoading && _cryptoAssets.isEmpty) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is CryptoLoaded) {
//               _cryptoAssets.addAll(state.assets);
//               // Sort the list by the value of the cryptocurrency
//               _cryptoAssets.sort((a, b) => b.priceUsd.compareTo(a.priceUsd));
//             } else if (state is CryptoError) {
//               return Center(child: Text(state.message));
//             }
//
//             return ListView.builder(
//               controller: _scrollController,
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               itemCount: _cryptoAssets.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == _cryptoAssets.length) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return CryptoItem(asset: _cryptoAssets[index], index: index);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../bloc/crypto_bloc.dart';

import '../bloc/crypto_event.dart';

import '../bloc/crypto_state.dart';

import '../model/crypto_asset.dart';

import '../widgets/crypto_item.dart';



class CryptoScreen extends StatefulWidget {

  @override

  _CryptoScreenState createState() => _CryptoScreenState();

}



class _CryptoScreenState extends State<CryptoScreen> {

  final ScrollController _scrollController = ScrollController();

  final List<CryptoAsset> _cryptoAssets = [];

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

    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent && !_isFetching) {

      _offset += 15;

      _fetchCryptoAssets();

    }

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(

        padding: const EdgeInsets.only(top: 24.0),

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
                  SnackBar(content: Text(state.message)));

            }

          },

          builder: (context, state) {

            if (state is CryptoInitial && _cryptoAssets.isEmpty) {

              return Center(child: CircularProgressIndicator());

            }

            return ListView.builder(

              controller: _scrollController,

              padding: EdgeInsets.symmetric(vertical: 8.0),

              itemCount: _cryptoAssets.length + (_isFetching ? 1 : 0),

              itemBuilder: (context, index) {

                if (index == _cryptoAssets.length) {

                  return Center(child: CircularProgressIndicator());

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