import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_tp/entities/usuarios.dart';

class UsuarioRepository {
  UsuarioRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection('usuarios');

  String _norm(String s) => s.trim().toLowerCase();

  Future<void> save(Usuario user) async {
    await _col.doc(_norm(user.gmail)).set(user.toMap());
  }

  Stream<List<Usuario>> streamAll() {
    return _col.snapshots().map((snap) {
      final list = snap.docs.map((d) => Usuario.fromMap(d.data())).toList();
      list.sort((a, b) => _norm(a.gmail).compareTo(_norm(b.gmail)));
      return list;
    });
  }

  Future<Usuario?> getByGmail(String gmail) async {
    final doc = await _col.doc(_norm(gmail)).get();
    if (!doc.exists) return null;
    return Usuario.fromMap(doc.data()!);
  }

  Future<bool> existsByGmail(String gmail) async {
    final doc = await _col.doc(_norm(gmail)).get();
    return doc.exists;
  }
}
