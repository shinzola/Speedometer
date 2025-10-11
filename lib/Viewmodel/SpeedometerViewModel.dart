import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

// ViewModel estende ChangeNotifier para notificar a View sobre mudanças de estado.
class SpeedometerViewModel extends ChangeNotifier {
  // Variáveis de estado privadas
  double _speed = 0.0;
  double _totalDistance = 0.0;
  bool _isHudMode = false;
  bool _hasPermission = false;
  String? _errorMessage;

  Position? _lastPosition;
  StreamSubscription<Position>? _positionStream;

  // Formatadores
  final NumberFormat _speedFormatter = NumberFormat('0', 'pt_BR');
  final NumberFormat _distanceFormatter = NumberFormat('0.00', 'pt_BR');

  // Getters públicos para a View acessar os dados
  double get speed => _speed;
  double get totalDistance => _totalDistance;
  bool get isHudMode => _isHudMode;
  bool get hasPermission => _hasPermission;
  String? get errorMessage => _errorMessage;

  String get formattedSpeed => _speedFormatter.format(_speed);
  String get formattedDistance => _distanceFormatter.format(_totalDistance);

  SpeedometerViewModel() {
    _initialize();
  }

  // Método de inicialização
  Future<void> _initialize() async {
    await WakelockPlus.enable();
    await _checkPermissionsAndStart();
    notifyListeners();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    WakelockPlus.disable();
    super.dispose();
  }

  // Lógica de permissões
  Future<void> _checkPermissionsAndStart() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _errorMessage =
          'Serviço de localização desativado. Por favor, habilite o GPS.';
      notifyListeners();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _errorMessage =
            'A permissão de localização é necessária para o funcionamento do app.';
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _errorMessage =
          'Permissão negada permanentemente. Abra as configurações do app para conceder a permissão.';
      notifyListeners();
      return;
    }

    _hasPermission = true;
    _errorMessage = null;
    _startTracking();
    notifyListeners();
  }

  // Lógica de monitoramento do GPS
  void _startTracking() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 0,
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      _speed = position.speed * 3.6;

      if (_lastPosition != null) {
        final distance = Geolocator.distanceBetween(
          _lastPosition!.latitude,
          _lastPosition!.longitude,
          position.latitude,
          position.longitude,
        );
        _totalDistance += distance / 1000.0;
      }
      _lastPosition = position;
      // Notifica a View que os dados foram atualizados
      notifyListeners();
    });
  }

  // Ações do usuário
  void resetDistance() {
    _totalDistance = 0.0;
    _lastPosition = null;
    notifyListeners();
  }

  void toggleHudMode() {
    _isHudMode = !_isHudMode;
    notifyListeners();
  }
}
