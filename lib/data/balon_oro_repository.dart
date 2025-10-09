import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tp/entities/BalonOro.dart';

class BalonOroRepository {
  BalonOroRepository(this._db);
  final FirebaseFirestore _db;

  Future<void> saveList(List<BalonOro> items) async {
    final doc = _db.collection('listas').doc('balon_oro');
    await doc.set({
      'items': items.map((e) => e.toMap()).toList(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
