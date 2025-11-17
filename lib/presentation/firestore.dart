import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tp/data/balon_oro_repository.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_application_tp/presentation/provider_balon_oro.dart';
import 'package:flutter_application_tp/presentation/auth_provider.dart';

final balonOroRepoProvider = Provider<BalonOroRepository>(
  (ref) => BalonOroRepository(FirebaseFirestore.instance),
);

final balonOroListStreamProvider = StreamProvider<List<BalonOro>>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        // Usuario NO logueado → stream vacío
        return Stream.value([]);
      }

      final uid = user.uid;

      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('listas')
          .doc('balon_oro');

      return docRef.snapshots().asyncMap((snapshot) async {
        // Si el documento NO existe → crearlo inicializando
        if (!snapshot.exists) {
          final defaultList = ref.read(lista);

          await docRef.set({
            'items': defaultList.map((e) => e.toMap()).toList(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

          return defaultList;
        }

        // Si existe → mapear datos
        final data = snapshot.data();
        final items = (data?['items'] as List? ?? []);
        final result =
            items
                .map((e) => BalonOro.fromMap(Map<String, dynamic>.from(e)))
                .toList()
              ..sort((a, b) => a.posicion.compareTo(b.posicion));

        return result;
      });
    },
    loading: () => Stream.value([]),
    error: (_, __) => Stream.value([]),
  );
});
