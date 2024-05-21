import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'bloc/crypto_bloc.dart';
import 'screens/crypto_screen.dart';

void main() {
  runApp(CriptoTestTask());
}

class CriptoTestTask extends StatelessWidget {
  const CriptoTestTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Assets',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => CryptoBloc(dio: Dio()),
        child: CryptoScreen(),
      ),
    );
  }
}