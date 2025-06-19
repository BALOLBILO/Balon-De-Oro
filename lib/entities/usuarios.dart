class Usuario {
  String name;
  String pasrword;
  String gmail;
  String direccion;
  Usuario({
    required this.name,
    required this.pasrword,
    required this.direccion,
    required this.gmail,
  });

  static bool existeUsuario(String gmail, List<Usuario> listaUsuario) {
    for (var Usuario in listaUsuario) {
      if (Usuario.gmail == gmail) {
        return true;
      }
    }

    return false;
  }
}
