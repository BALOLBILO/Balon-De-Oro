import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CambiarScreen extends ConsumerWidget {
  const CambiarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cambiarJugador = ref.read(jugadorCambiar);

    final TextEditingController controller1 = TextEditingController();
    final listaJugadores = ref.read(lista);

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
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: controller1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Posición a cambiar'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String posicionText = controller1.text;
                  int? posicion = int.tryParse(posicionText);
                  if (posicion == null || posicionText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Campo vacío o inválido"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (BalonOro.posicionRepetida1(
                    listaJugadores,
                    posicion,
                    cambiarJugador.posicion,
                  )) {
                    for (final jugador in listaJugadores) {
                      if (jugador.posicion == posicion) {
                        jugador.posicion = cambiarJugador.posicion;
                        cambiarJugador.posicion = posicion;
                      }
                    }

                    final listaOrdenada = BalonOro.ordenar(listaJugadores);
                    ref.read(lista.notifier).state = listaOrdenada;
                    context.go('/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("La posición no existe o es la misma"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Cambiar'),
              ),
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
