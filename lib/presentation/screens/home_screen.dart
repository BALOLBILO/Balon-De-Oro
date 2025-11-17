import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_cambiar_jugador.dart';
import 'package:flutter_application_tp/presentation/provider_descripcion.dart';
import 'package:flutter_application_tp/presentation/provider_editar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_tp/presentation/firestore.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listaAsync = ref.watch(balonOroListStreamProvider);

    return listaAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (rankBalonOro) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ranking Balón de Oro 2017'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Cerrar sesión',
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text('Cerrar sesión'),
                          content: const Text(
                            '¿Seguro que querés cerrar sesión?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Cerrar sesión'),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    await FirebaseAuth.instance.signOut();

                    /// 🔥 IMPORTANTE: invalidar el stream
                    ref.invalidate(balonOroListStreamProvider);

                    if (context.mounted) {
                      context.go('/inicio'); // o donde esté tu pantalla inicial
                    }
                  }
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: rankBalonOro.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    ref.read(jugadorDescripcion.notifier).state =
                        rankBalonOro[index];
                    context.push('/descripcion');
                  },
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return _AccionesHome(
                          rankBalonOro: rankBalonOro,
                          index: index,
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
            onPressed: () => context.push('/agregar'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class _AccionesHome extends ConsumerWidget {
  const _AccionesHome({required this.rankBalonOro, required this.index});
  final List<BalonOro> rankBalonOro;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Editar'),
            onTap: () {
              Navigator.pop(context);
              ref.read(jugadorEditar.notifier).state = rankBalonOro[index];
              context.push('/editar');
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_calls),
            title: const Text('Cambiar'),
            onTap: () {
              Navigator.pop(context);
              ref.read(jugadorCambiar.notifier).state = rankBalonOro[index];
              context.push('/cambiar');
            },
          ),
          ListTile(
            leading: const Icon(Icons.sort),
            title: const Text('Ordenar Lista'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Confirmar acción'),
                      content: const Text(
                        '¿Estás seguro de que querés ordenar la lista?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Aceptar'),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {
                final ordenada = BalonOro.listaEnumerada(rankBalonOro);
                await ref.read(balonOroRepoProvider).saveList(ordenada);
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning),
            title: const Text('Volver a original'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Confirmar acción'),
                      content: const Text(
                        '¿Seguro que querés restaurar la lista original? Perderás los cambios.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Aceptar'),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {
                final original = BalonOro.listaOriginal();
                await ref.read(balonOroRepoProvider).saveList(original);
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Eliminar'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Confirmar eliminación'),
                      content: Text(
                        '¿Seguro que querés eliminar a "${rankBalonOro[index].name}"?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Eliminar'),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {
                final nueva = [
                  for (final j in rankBalonOro)
                    if (j.name != rankBalonOro[index].name) j,
                ];
                await ref.read(balonOroRepoProvider).saveList(nueva);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
