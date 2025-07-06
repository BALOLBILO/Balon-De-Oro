import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_descripcion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DescripcionScreen extends ConsumerWidget {
  const DescripcionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BalonOro jugador = ref.watch(jugadorDescripcion);

    return Scaffold(
      appBar: AppBar(title: Text(jugador.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(
              width: 300, // o el ancho que quieras
              child: Text(jugador.descripcion, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
