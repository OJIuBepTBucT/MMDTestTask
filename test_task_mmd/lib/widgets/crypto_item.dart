import 'package:flutter/material.dart';
import '../model/crypto_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoItem extends StatelessWidget {
  final CryptoModel asset;
  final int index;

  const CryptoItem({super.key, required this.asset, required this.index});

  Color _generateColor(int index) {
    int maxColors = 256 * 256 * 256; // 16,777,216 colors
    if (index >= maxColors) {
      throw ArgumentError('Index must be less than $maxColors');
    }

    // Simple hash function to mix up colors
    int hash = _simpleHash(index);
    int b = hash % 256;
    int g = (hash ~/ 256) % 256;
    int r = (hash ~/ (256 * 256)) % 256;
    return Color.fromARGB(255, r, g, b).withOpacity(0.1);
  }

  int _simpleHash(int x) {
    // Simple hash function to mix up the bits
    x = ((x >> 16) ^ x) * 0x45d9f3b;
    x = ((x >> 16) ^ x) * 0x45d9f3b;
    x = (x >> 16) ^ x;
    return x;
  }

  String _formatPrice(double price) {
    final numberFormat = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );

    return numberFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.h,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: _generateColor(index),
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              asset.symbol,
              style: TextStyle(
                fontFamily: 'SFProText',
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
                height: 24.h / 17.sp,
                letterSpacing: -0.41.sp,
                color: const Color(0xFF17171A),
              ),
            ),
          ),
          Text(
            _formatPrice(asset.priceUsd),
            style: TextStyle(
              fontFamily: 'SFProText',
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
              height: 24.h / 17.sp,
              letterSpacing: -0.41.sp,
              color: const Color(0xFF17171A),
            ),
          ),
        ],
      ),
    );
  }
}