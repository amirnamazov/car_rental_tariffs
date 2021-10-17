import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/tariffs/cubit/tariffs_cubit.dart';
import 'pages/tariffs/tariffs_page.dart';

void main() => runApp(CounterApp());

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => TariffsCubit(),
        child: TariffsPage(),
      ),
    );
  }
}
