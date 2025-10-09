import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tp/data/usuario_repository.dart';
import 'package:flutter_application_tp/entities/usuarios.dart';

final usuarioRepoProvider = Provider<UsuarioRepository>(
  (ref) => UsuarioRepository(FirebaseFirestore.instance),
);

final usuariosStreamProvider = StreamProvider<List<Usuario>>(
  (ref) => ref.watch(usuarioRepoProvider).streamAll(),
);

final currentUserProvider = StateProvider<Usuario?>((ref) => null);

final usuarioPorGmailProvider = FutureProvider.family<Usuario?, String>((
  ref,
  gmail,
) {
  return ref.read(usuarioRepoProvider).getByGmail(gmail);
});

final usuarioExisteProvider = FutureProvider.family<bool, String>((
  ref,
  gmail,
) async {
  final u = await ref.read(usuarioRepoProvider).getByGmail(gmail);
  return u != null;
});
