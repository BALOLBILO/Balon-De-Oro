import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_editar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_tp/presentation/firestore.dart';

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
    final listaAsync = ref.watch(balonOroListStreamProvider);

    if (!_initialized) {
      controller1 = TextEditingController(text: jugador.name);
      controller2 = TextEditingController(text: jugador.posicion.toString());
      controller3 = TextEditingController(text: jugador.url);
      controller4 = TextEditingController(text: jugador.descripcion);
      _initialized = true;
    }

    return listaAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (listaActual) {
        return Scaffold(
          appBar: AppBar(title: Text('Editar: ${jugador.name}')),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('nombre'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller2,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('posición'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('descripcion'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller3,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('url'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () async {
                        String nombre = controller1.text.trim();
                        String posicionText = controller2.text.trim();
                        String url = controller3.text.trim();
                        String descripcion = controller4.text.trim();
                        final posParsed = int.tryParse(posicionText);
                        final posicionNueva = posParsed ?? jugador.posicion;

                        if (nombre.isEmpty) nombre = jugador.name;
                        if (descripcion.isEmpty)
                          descripcion = jugador.descripcion;
                        if (url.isEmpty) url = jugador.url;

                        final repetida = BalonOro.posicionRepetida1(
                          listaActual,
                          posicionNueva,
                          jugador.posicion,
                        );
                        if (repetida) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Posición repetida'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final editado = BalonOro(
                          name: nombre,
                          posicion: posicionNueva,
                          descripcion: descripcion,
                          url: url,
                        );

                        final nuevaLista = [
                          for (final j in listaActual)
                            if (j.name == jugador.name) editado else j,
                        ];
                        final listaOrdenada = BalonOro.ordenar(nuevaLista);

                        try {
                          await ref
                              .read(balonOroRepoProvider)
                              .saveList(listaOrdenada);
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Lista guardada en Firebase'),
                            ),
                          );
                          context.go('/home');
                        } catch (e) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No se pudo guardar: $e')),
                          );
                        }
                      },
                      child: const Text('Editar'),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listaActual.length,
                      itemBuilder: (context, index) {
                        final j = listaActual[index];
                        return ListTile(
                          title: Text(j.name),
                          subtitle: Text('Posición: ${j.posicion}'),
                          leading: Image.network(
                            j.url,
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
      },
    );
  }
}
