import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/firestore.dart';
import 'package:go_router/go_router.dart';

class AgregarScreen extends ConsumerStatefulWidget {
  const AgregarScreen({super.key});

  @override
  ConsumerState<AgregarScreen> createState() => _AgregarScreenState();
}

class _AgregarScreenState extends ConsumerState<AgregarScreen> {
  final TextEditingController controllerNombre = TextEditingController();
  final TextEditingController controllerPos = TextEditingController();
  final TextEditingController controllerUrl = TextEditingController();
  final TextEditingController controllerDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final listaAsync = ref.watch(balonOroListStreamProvider);

    return listaAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (listaActual) {
        return Scaffold(
          appBar: AppBar(title: const Text('Agregar')),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: controllerNombre,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Nombre'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: controllerPos,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Posición'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: controllerDesc,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Descripción'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: controllerUrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('URL (opcional)'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      String nombre = controllerNombre.text.trim();
                      String posText = controllerPos.text.trim();
                      String descripcion = controllerDesc.text.trim();
                      String url = controllerUrl.text.trim();
                      final posicion = int.tryParse(posText);

                      if (nombre.isEmpty ||
                          posicion == null ||
                          descripcion.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Campo vacío o posición inválida'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (url.isEmpty) {
                        url =
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGgNXbKwWZKsDgN4qg8RaMQgvuN6STDZ_Vdw&s';
                      }

                      if (BalonOro.posicionRepetida2(listaActual, posicion)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Posición repetida'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final nuevo = BalonOro(
                        name: nombre,
                        posicion: posicion,
                        descripcion: descripcion,
                        url: url,
                      );

                      final listaNueva = [...listaActual, nuevo];
                      final listaOrdenada = BalonOro.ordenar(listaNueva);

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
                    child: const Text('Agregar'),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listaActual.length,
                    itemBuilder: (context, index) {
                      final jugador = listaActual[index];
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
      },
    );
  }
}
