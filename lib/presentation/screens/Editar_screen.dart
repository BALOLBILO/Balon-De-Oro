import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_editar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';
import 'package:go_router/go_router.dart';

class EditarScreen extends ConsumerStatefulWidget {
  const EditarScreen({super.key});

  @override
  ConsumerState<EditarScreen> createState() => _EditarScreenState();
}

class _EditarScreenState extends ConsumerState<EditarScreen> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late final TextEditingController controller3;
  late final TextEditingController controller4;
  bool _initialized = false;

  @override
  Widget build(BuildContext context) {
    final jugador = ref.watch(jugadorEditar);
    final listaJugadores = ref.read(lista);
    if (!_initialized) {
      controller1 = TextEditingController(text: jugador.name);
      controller2 = TextEditingController(text: jugador.posicion.toString());
      controller3 = TextEditingController(text: jugador.url);
      controller4 = TextEditingController(text: jugador.descripcion);
      _initialized = true;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Editar: ${jugador.name}')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(jugador.name),
                Text('Posición: ${jugador.posicion}'),
                Image.network(
                  jugador.url,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text('nombre'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller2,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text('posición'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller4,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text('descripcion'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: controller3,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: Text('url'),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String nombre = controller1.text;
                    String posiciontext = controller2.text;
                    String url = controller3.text;
                    String descripcion = controller4.text;
                    int? posicionNullable = int.tryParse(posiciontext);
                    int posicion = posicionNullable ?? jugador.posicion;

                    final listaActual = ref.read(lista);

                    if (nombre.isEmpty) {
                      nombre = jugador.name;
                    }
                    if (descripcion.isEmpty) {
                      descripcion = jugador.descripcion;
                    }

                    if (url.isEmpty) {
                      url = jugador.url;
                    }
                    if (BalonOro.posicionRepetida1(
                      listaActual,
                      posicion,
                      jugador.posicion,
                    )) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Posicion repetida"),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      BalonOro editar = BalonOro(
                        name: nombre,
                        posicion: posicion,
                        descripcion: descripcion,
                        url: url,
                      );

                      final nuevaLista = [
                        for (final jugadorLista in listaActual)
                          if (jugadorLista.name == jugador.name)
                            editar
                          else
                            jugadorLista,
                      ];

                      final listaOrdenada = BalonOro.ordenar(nuevaLista);

                      ref.read(lista.notifier).state = listaOrdenada;

                      context.go('/home');
                    }
                  },
                  child: Text('Editar'),
                ),
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
      ),
    );
  }
}
