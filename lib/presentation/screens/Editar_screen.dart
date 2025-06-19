import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';
import 'package:go_router/go_router.dart';

class EditarScreen extends ConsumerStatefulWidget {
  final BalonOro jugadorEditar;

  const EditarScreen({super.key, required this.jugadorEditar});

  @override
  ConsumerState<EditarScreen> createState() => _EditarScreenState();
}

class _EditarScreenState extends ConsumerState<EditarScreen> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final jugador = widget.jugadorEditar;

    return Scaffold(
      appBar: AppBar(title: Text('Editar: ${jugador.name}')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  int? posicionNullable = int.tryParse(posiciontext);
                  int posicion = posicionNullable ?? jugador.posicion;

                  final listaActual = ref.read(lista);

                  if (nombre.isEmpty) {
                    nombre = jugador.name;
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
            ],
          ),
        ),
      ),
    );
  }
}
