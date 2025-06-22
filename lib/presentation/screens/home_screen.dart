import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador.dart';
import 'package:flutter_application_tp/presentation/provider_copia_lista.dart';
import 'package:flutter_application_tp/presentation/provider_original.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankBalonOro = ref.watch(lista);

    return Scaffold(
      appBar: AppBar(title: Text('Ranking Balón de Oro 2017')),
      body: ListView.builder(
        itemCount: rankBalonOro.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.sort),
                            title: Text('Ordenar Lista'),
                            onTap: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Confirmar'),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: const Color.fromARGB(
                                    96,
                                    231,
                                    19,
                                    19,
                                  ),
                                  action: SnackBarAction(
                                    label: 'Si',
                                    onPressed: () {
                                      final listaJugador = ref.read(lista);
                                      final listaEnumerada =
                                          BalonOro.listaEnumerada(listaJugador);

                                      ref.read(lista.notifier).state =
                                          listaEnumerada;
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.swap_calls),
                            title: Text('Cambiar'),
                            onTap: () {
                              Navigator.pop(context);
                              ref.read(jugadorCambiar.notifier).state =
                                  rankBalonOro[index];

                              context.push('/cambiar');
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Editar'),
                            onTap: () {
                              Navigator.pop(context);

                              context.push(
                                '/editar',
                                extra: rankBalonOro[index],
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.warning),
                            title: Text('Volver a original'),
                            onTap: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Confirmar'),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: const Color.fromARGB(
                                    96,
                                    231,
                                    19,
                                    19,
                                  ),
                                  action: SnackBarAction(
                                    label: 'Si',
                                    onPressed: () {
                                      final listah = BalonOro.listaOriginal();

                                      ref.read(lista.notifier).state = listah;
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Eliminar'),
                            onTap: () {
                              ref.read(listaSeguridad.notifier).state =
                                  rankBalonOro;
                              final listaActual = ref.read(lista);
                              final nuevaLista = [
                                for (final jugador in listaActual)
                                  if (jugador.name != listaActual[index].name)
                                    jugador,
                              ];
                              ref.read(lista.notifier).state = nuevaLista;
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Jugador eliminado'),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: const Color.fromARGB(
                                    96,
                                    231,
                                    19,
                                    19,
                                  ),
                                  action: SnackBarAction(
                                    label: 'Deshacer',
                                    onPressed: () {
                                      ref.read(lista.notifier).state = ref.read(
                                        listaSeguridad,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              title: Text(rankBalonOro[index].name),
              subtitle: Text('Posición: ${rankBalonOro[index].posicion}'),
              leading: Image.network(
                rankBalonOro[index].url,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/agregar');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
