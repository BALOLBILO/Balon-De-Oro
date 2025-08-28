import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestFirestorePage extends StatefulWidget {
  const TestFirestorePage({super.key});
  @override
  State<TestFirestorePage> createState() => _TestFirestorePageState();
}

class _TestFirestorePageState extends State<TestFirestorePage> {
  final _col = FirebaseFirestore.instance.collection('ping');

  Future<void> _write() async {
    await _col.add({'msg': 'hola', 'ts': FieldValue.serverTimestamp()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Ping')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _col.orderBy('ts', descending: true).limit(10).snapshots(),
        builder: (context, snap) {
          if (snap.hasError)
            return const Center(child: Text('Error Firestore'));
          if (!snap.hasData)
            return const Center(child: CircularProgressIndicator());
          final docs = snap.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final d = docs[i].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(d['msg']?.toString() ?? '(sin msg)'),
                subtitle: Text(
                  (d['ts']?.toDate() ?? DateTime.now()).toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _write,
        child: const Icon(Icons.send),
      ),
    );
  }
}
