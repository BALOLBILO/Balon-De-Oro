import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador2.dart';
import 'package:flutter_application_tp/presentation/firestore.dart';

class CambiarScreen extends ConsumerWidget {
  const CambiarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cambiarJugador = ref.read(jugadorCambiar);
    final posicionSeleccionada = ref.watch(posicionSeleccionadaProvider);
    final texto = ref.watch(textoSeleccionProvider);

    final listaAsync = ref.watch(balonOroListStreamProvider);

    return listaAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (listaJugadores) {
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
                    style: const TextStyle(fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (posicionSeleccionada == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No elegiste a nadie'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final jugadorA = cambiarJugador;
                      final jugadorB = listaJugadores.firstWhere(
                        (j) => j.posicion == posicionSeleccionada,
                      );

                      final listaSwap = [
                        for (final j in listaJugadores)
                          if (j.name == jugadorA.name)
                            BalonOro(
                              name: j.name,
                              posicion: jugadorB.posicion,
                              descripcion: j.descripcion,
                              url: j.url,
                            )
                          else if (j.name == jugadorB.name)
                            BalonOro(
                              name: j.name,
                              posicion: jugadorA.posicion,
                              descripcion: j.descripcion,
                              url: j.url,
                            )
                          else
                            j,
                      ];
                      final listaOrdenada = BalonOro.ordenar(listaSwap);

                      try {
                        await ref
                            .read(balonOroRepoProvider)
                            .saveList(listaOrdenada);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cambios guardados')),
                        );
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error guardando: $e')),
                        );
                      }

                      ref.read(posicionSeleccionadaProvider.notifier).state =
                          null;
                      ref.read(textoSeleccionProvider.notifier).state =
                          'Selecciona jugador';
                      if (context.mounted) context.go('/home');
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
                          ref
                              .read(posicionSeleccionadaProvider.notifier)
                              .state = jugador.posicion;
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
      },
    );
  }
}
