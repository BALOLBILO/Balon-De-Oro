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
  final TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listaJugadores = ref.read(lista);
    return Scaffold(
      appBar: AppBar(title: Text('Agregar')),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: Text('Nombre'),
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
                    label: Text('Posición'),
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
                    label: Text('Descripcion'),
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
                    label: Text('Url'),
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
                  int? posicion = int.tryParse(posiciontext);

                  if (nombre.isEmpty ||
                      posicion == null ||
                      descripcion.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("campo vacio"),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    if (url.isEmpty) {
                      url =
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGgNXbKwWZKsDgN4qg8RaMQgvuN6STDZ_Vdw&s';
                    }
                    final nuevo = BalonOro(
                      name: nombre,
                      posicion: posicion,
                      descripcion: descripcion,
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
