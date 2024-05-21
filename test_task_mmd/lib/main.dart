import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/crypto_bloc.dart';
import 'screens/crypto_screen.dart';

void main() {
  runApp(const CryptoTestTask());
}

class CryptoTestTask extends StatelessWidget {
  const CryptoTestTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 849),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Crypto Assets',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocProvider(
            create: (context) => CryptoBloc(dio: Dio()),
            child: const CryptoScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}