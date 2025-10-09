import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tp/data/balon_oro_repository.dart';

import 'package:flutter_application_tp/entities/BalonOro.dart';

final balonOroRepoProvider = Provider<BalonOroRepository>(
  (ref) => BalonOroRepository(FirebaseFirestore.instance),
);

final balonOroListStreamProvider = StreamProvider<List<BalonOro>>((ref) {
  return FirebaseFirestore.instance
      .collection('listas')
      .doc('balon_oro')
      .snapshots()
      .map((snap) {
        final data = snap.data();
        final items = (data?['items'] as List<dynamic>? ?? []);
        final list =
            items
                .map((e) => BalonOro.fromMap(Map<String, dynamic>.from(e)))
                .toList();
        list.sort((a, b) => a.posicion.compareTo(b.posicion));
        return list;
      });
});
