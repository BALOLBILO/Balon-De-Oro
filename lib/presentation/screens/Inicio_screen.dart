import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_tp/entities/usuarios.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InicioScreen> {
  List<Usuario> listaUsuarios = [];
  @override
  void initState() {
    super.initState();
    listaUsuarios = [
      Usuario(
        name: 'balo',
        pasrword: '123',
        direccion: 'morelos 619',
        gmail: 'balobilo@gmail.com',
      ),
      Usuario(
        name: 'papa',
        pasrword: '321',
        direccion: 'morelos 196',
        gmail: 'papa@gmail.com',
      ),
      Usuario(
        name: 'lala',
        pasrword: '213',
        direccion: 'morelos 916',
        gmail: 'lala@gmail.com',
      ),
      Usuario(
        name: 'sasa',
        pasrword: '231',
        direccion: 'morelos 691',
        gmail: 'sasa@gmail.com',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/login', extra: listaUsuarios);
              },
              child: Text("Iniciar Sesión"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.push('/registrarse', extra: listaUsuarios);
              },
              child: Text("Crear sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
