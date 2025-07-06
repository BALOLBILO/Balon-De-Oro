import 'package:flutter_riverpod/flutter_riverpod.dart';

final posicionSeleccionadaProvider = StateProvider<int?>((ref) => null);
final textoSeleccionProvider = StateProvider<String>(
  (ref) => 'selecciona jugador',
);
