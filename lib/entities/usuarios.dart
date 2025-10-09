class Usuario {
  final String gmail;
  final String password;

  Usuario({required this.gmail, required this.password});

  Map<String, dynamic> toMap() => {'gmail': gmail, 'password': password};

  static Usuario fromMap(Map<String, dynamic> map) => Usuario(
    gmail: map['gmail'] as String,
    password: map['password'] as String,
  );

  static bool existeUsuario(String gmail, List<Usuario> lista) {
    return lista.any((u) => u.gmail == gmail);
  }
}
