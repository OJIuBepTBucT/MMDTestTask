// import 'package:flutter/material.dart';
// import '../model/crypto_asset.dart';
// import 'dart:math';
//
// class CryptoItem extends StatelessWidget {
//   final CryptoAsset asset;
//   final int index;
//
//   CryptoItem({required this.asset, required this.index});
//
//   Color _generateColor(int index) {
//     final Random random = Random(index);
//     return Color.fromARGB(
//       26,
//       random.nextInt(256),
//       random.nextInt(256),
//       random.nextInt(256),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 84,
//       padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//       child: Row(
//         children: [
//           Container(
//             width: 56,
//             height: 56,
//             decoration: BoxDecoration(
//               color: _generateColor(index),
//               borderRadius: BorderRadius.circular(18), // Rounded rectangle
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               asset.symbol,
//               style: TextStyle(
//                 fontFamily: 'SFProText',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 17,
//                 height: 24 / 17,
//                 letterSpacing: -0.41,
//                 color: Color(0xFF17171A),
//               ),
//             ),
//           ),
//           Text(
//             '\$${asset.priceUsd.toStringAsFixed(2)}',
//             style: TextStyle(
//               fontFamily: 'SFProText',
//               fontWeight: FontWeight.w600,
//               fontSize: 17,
//               height: 24 / 17,
//               letterSpacing: -0.41,
//               color: Color(0xFF17171A),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/crypto_asset.dart';
import 'dart:math';

class CryptoItem extends StatelessWidget {
  final CryptoAsset asset;
  final int index;

  CryptoItem({required this.asset, required this.index});

  Color _generateColor(int index) {
    final Random random = Random(index);
    return Color.fromARGB(
      26, // Adjust the alpha value to make it paler
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  String _formatPrice(double price) {
    final numberFormat = NumberFormat.currency(
        locale: 'en_US', symbol: '\$', decimalDigits: 2);
    return numberFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _generateColor(index),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              asset.symbol,
              style: TextStyle(
                fontFamily: 'SFProText',
                fontWeight: FontWeight.w600,
                fontSize: 17,
                height: 24 / 17,
                letterSpacing: -0.41,
                color: Color(0xFF17171A),
              ),
            ),
          ),
          Text(
            _formatPrice(asset.priceUsd),
            style: TextStyle(
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w600,
              fontSize: 17,
              height: 24 / 17,
              letterSpacing: -0.41,
              color: Color(0xFF17171A),
            ),
          ),
        ],
      ),
    );
  }
}