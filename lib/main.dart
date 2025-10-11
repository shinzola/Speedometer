import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapidometro/Viewmodel/SpeedometerViewModel.dart';
import 'package:rapidometro/view/SpeedometerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider é o que "provê" o ViewModel para a View.
    // Todos os widgets filhos de MyApp terão acesso ao SpeedometerViewModel.
    return ChangeNotifierProvider(
      create: (context) => SpeedometerViewModel(),
      child: MaterialApp(
        title: 'Velocímetro HUD',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const SpeedometerScreen(),
      ),
    );
  }
}
