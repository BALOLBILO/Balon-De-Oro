import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';

class BalonOroRepository {
  BalonOroRepository(this._db);
  final FirebaseFirestore _db;

  Future<void> saveList(List<BalonOro> items) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No hay usuario logueado');
    }

    final uid = user.uid;

    final doc = _db
        .collection('users')
        .doc(uid)
        .collection('listas')
        .doc('balon_oro');

    await doc.set({
      'items': items.map((e) => e.toMap()).toList(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
