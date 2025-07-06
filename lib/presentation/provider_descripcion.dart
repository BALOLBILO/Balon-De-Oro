import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jugadorDescripcion = StateProvider<BalonOro>((ref) {
  return BalonOro(
    name: 'Jugador por defecto',
    descripcion: "descrpicion por defecto",
    posicion: 99,
    url: 'https://example.com/default.jpg',
  );
});
