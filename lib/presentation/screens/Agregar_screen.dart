import 'package:flutter/material.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:go_router/go_router.dart';

class AgregarScreen extends ConsumerStatefulWidget {
  const AgregarScreen({super.key});

  @override
  ConsumerState<AgregarScreen> createState() => _AgregarScreenState();
}

class _AgregarScreenState extends ConsumerState<AgregarScreen> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                int? posicion = int.tryParse(posiciontext);

                if (nombre.isEmpty || posicion == null || url.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("campo vacio"),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  final nuevo = BalonOro(
                    name: nombre,
                    posicion: posicion,
                    url: url,
                  );

                  final listaActual = ref.read(lista);
                  if (BalonOro.posicionRepetida2(listaActual, posicion)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Posicion repetida"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    final listaNueva = List<BalonOro>.from(listaActual);
                    listaNueva.add(nuevo);
                    final listaOrdenada = BalonOro.ordenar(listaNueva);

                    ref.read(lista.notifier).state = listaOrdenada;

                    context.go('/home');
                  }
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
