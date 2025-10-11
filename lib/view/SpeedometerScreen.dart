import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapidometro/Viewmodel/SpeedometerViewModel.dart';

class SpeedometerScreen extends StatelessWidget {
  const SpeedometerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 'Consumer' reconstrói a UI quando o ViewModel notifica sobre mudanças.
    // 'watch' é uma alternativa mais moderna e concisa.
    final viewModel = context.watch<SpeedometerViewModel>();

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(viewModel.isHudMode ? pi : 0),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            // Se houver uma mensagem de erro (ex: permissão negada), exibe.
            // Caso contrário, mostra o velocímetro.
            child: viewModel.errorMessage != null
                ? _buildErrorDisplay(viewModel.errorMessage!)
                : _buildSpeedometer(context, viewModel),
          ),
        ),
      ),
    );
  }

  // Widget principal do velocímetro
  Widget _buildSpeedometer(
      BuildContext context, SpeedometerViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Spacer(),
        _buildSpeedDisplay(viewModel),
        _buildDistanceDisplay(viewModel),
        const Spacer(),
        _buildActionButtons(context, viewModel),
      ],
    );
  }

  // Mostrador de velocidade
  Widget _buildSpeedDisplay(SpeedometerViewModel viewModel) {
    return Column(
      children: [
        Text(
          viewModel.formattedSpeed,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 150,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Colors.cyanAccent,
          ),
        ),
        const Text(
          'km/h',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // Mostrador de distância
  Widget _buildDistanceDisplay(SpeedometerViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Text(
            viewModel.formattedDistance,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: Colors.white,
            ),
          ),
          const Text(
            'km',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Botões de ação
  Widget _buildActionButtons(
      BuildContext context, SpeedometerViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 36,
            color: Colors.white70,
            // Chama o método do ViewModel
            onPressed: viewModel.resetDistance,
            tooltip: 'Zerar Distância',
          ),
          IconButton(
            icon: Icon(
              viewModel.isHudMode
                  ? Icons.phone_android_sharp
                  : Icons.directions_car,
            ),
            iconSize: 36,
            color: viewModel.isHudMode ? Colors.cyanAccent : Colors.white70,
            // Chama o método do ViewModel
            onPressed: viewModel.toggleHudMode,
            tooltip: 'Alternar Modo HUD',
          ),
        ],
      ),
    );
  }

  // Widget para exibir erros
  Widget _buildErrorDisplay(String message) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
