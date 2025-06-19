import 'package:flutter/material.dart';
import 'package:flutter_application_tp/entities/usuarios.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  final List<Usuario> listaUsuarios;
  const LoginScreen({super.key, required this.listaUsuarios});

  @override
  State<LoginScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginScreen> {
  String a = "SE";
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  bool mostrarContra = true;
  List<Usuario> listaUsuarios = [];
  @override
  void initState() {
    super.initState();
    listaUsuarios = widget.listaUsuarios;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

            const SizedBox(height: 100),

            SizedBox(
              width: 200,
              child: TextField(
                controller: controller2,
                obscureText: mostrarContra,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      a == "SE" ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        if (mostrarContra == false) {
                          mostrarContra = true;
                          a = "SE";
                        } else {
                          mostrarContra = false;
                          a = "HE";
                        }
                      });
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Builder(
              builder:
                  (context) => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        String input1 = controller1.text;
                        String input2 = controller2.text;

                        Usuario loginUsuario = listaUsuarios.firstWhere(
                          (u) => u.gmail == input1,
                          orElse:
                              () => Usuario(
                                name: '',
                                pasrword: '',
                                direccion: '',
                                gmail: '',
                              ), // devuelve null si no encuentra
                        );

                        if (input1.isEmpty && input2.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("usuario y contraseña vacía"),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (input1.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Usuario vacío"),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (input2.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Contraseña vacía"),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (loginUsuario.gmail == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("No existe usuario"),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (input1 == loginUsuario.gmail &&
                            input2 == loginUsuario.pasrword) {
                          context.push('/home', extra: loginUsuario);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "usuario y/o contraseña incorrecta",
                              ),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      });
                    },
                    child: const Text("login"),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
