import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CambiarScreen extends ConsumerWidget {
  const CambiarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cambiarJugador = ref.read(jugadorCambiar);
    final listaJugadores = ref.read(lista);
    final posicionSeleccionada = ref.watch(posicionSeleccionadaProvider);
    final texto = ref.watch(textoSeleccionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cambiar')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Jugador a cambiar: ${cambiarJugador.name} (Posición ${cambiarJugador.posicion})',
                style: TextStyle(fontSize: 11),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (posicionSeleccionada == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No elegiste a nadie"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    for (final jugador in listaJugadores) {
                      if (jugador.posicion == posicionSeleccionada) {
                        final temp = jugador.posicion;
                        jugador.posicion = cambiarJugador.posicion;
                        cambiarJugador.posicion = temp;
                        break;
                      }
                    }

                    final listaOrdenada = BalonOro.ordenar(listaJugadores);
                    ref.read(lista.notifier).state = listaOrdenada;
                    ref.read(posicionSeleccionadaProvider.notifier).state =
                        null;
                    ref.read(textoSeleccionProvider.notifier).state =
                        'Selecciona jugador';
                    context.go('/home');
                  }
                },
                child: const Text('Cambiar'),
              ),
              const SizedBox(height: 20),
              Text(texto),
              const SizedBox(height: 30),
              const Text('Lista actual de jugadores:'),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listaJugadores.length,
                itemBuilder: (context, index) {
                  final jugador = listaJugadores[index];
                  return ListTile(
                    onTap: () {
                      ref.read(posicionSeleccionadaProvider.notifier).state =
                          jugador.posicion;
                      ref.read(textoSeleccionProvider.notifier).state =
                          'Seleccionaste: ${jugador.name}';
                    },
                    title: Text(jugador.name),
                    subtitle: Text('Posición: ${jugador.posicion}'),
                    leading: Image.network(
                      jugador.url,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
