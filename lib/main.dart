import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String usuario = "BalobiloSZN";
  String contrasena = "barabAra";
  String a = "SE";
  TextEditingController controller1 = TextEditingController();
  String input1 = "";

  TextEditingController controller2 = TextEditingController();
  String input2 = "";

  bool mostrarContra = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 0),
              Text("Ingrese usuario"),
              SizedBox(height: 10),
              SizedBox(width: 200, child: TextField(controller: controller1)),

              SizedBox(height: 100),

              Text("Ingrese contraseña"),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: controller2,
                      obscureText: mostrarContra,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
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
                    child: Text(a),
                  ),
                ],
              ),

              SizedBox(height: 20),
              SizedBox(height: 30),
              Builder(
                builder:
                    (context) => ElevatedButton(
                      onPressed: () {
                        setState(() {
                          input1 = controller1.text;
                          input2 = controller2.text;
                          if (input1 == usuario && input2 == contrasena) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Usuario correcto"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }

                          if (input1 == "" && input2 != "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Usuario vacío"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                          if (input2 == "" && input1 != "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Contraseña vacía"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.red,
                              ),
                            );

                            if (input1 == "" && input2 == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("usuario y contraseña vacía"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }

                          if (input1 != "" && input2 != "") {
                            if (input1 != usuario || input2 != contrasena) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "usuario y/o contraseña incorrecta",
                                  ),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        });
                      },
                      child: Text("login"),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
