import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_tp/entities/usuarios.dart';

class RegistrarseScreen extends StatefulWidget {
  final List<Usuario> listaUsuarios;
  const RegistrarseScreen({super.key, required this.listaUsuarios});

  @override
  State<RegistrarseScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegistrarseScreen> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  String input1 = "";
  String input2 = "";
  String input3 = "";
  String input4 = "";

  List<Usuario> listaUsuarios = [];
  @override
  void initState() {
    super.initState();
    listaUsuarios = widget.listaUsuarios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller1,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text('gmail'),
                ),
              ),
            ),

            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller3,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text('contraseña'),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text('direccion'),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextField(
                controller: controller4,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: Text('nombre'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Builder(
              builder:
                  (context) => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        input1 = controller1.text;
                        input2 = controller2.text;
                        input3 = controller3.text;
                        input4 = controller4.text;
                        if (input1.isEmpty ||
                            input2.isEmpty ||
                            input3.isEmpty ||
                            input4.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Campo vacio"),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          Usuario usuarioNuevo = Usuario(
                            name: input4,
                            pasrword: input3,
                            direccion: input2,
                            gmail: input1,
                          );
                          if (Usuario.existeUsuario(
                            usuarioNuevo.gmail,
                            listaUsuarios,
                          )) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("el usuario ya existe"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            listaUsuarios.add(usuarioNuevo);

                            context.push('/login', extra: listaUsuarios);
                          }
                        }
                      });
                    },
                    child: Text("crear cuenta"),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
