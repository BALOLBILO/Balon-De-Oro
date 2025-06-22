class BalonOro {
  String name;
  int posicion;
  String url;

  BalonOro({required this.name, required this.posicion, required this.url});

  static List<BalonOro> ordenar(List<BalonOro> lista) {
    final listaNueva = [...lista];
    listaNueva.sort((a, b) => a.posicion.compareTo(b.posicion));
    return listaNueva;
  }

  static bool posicionRepetida1(
    List<BalonOro> lista,
    int posicion,
    int posicionOriginal,
  ) {
    for (final jugador in lista) {
      if (jugador.posicion == posicion && posicion != posicionOriginal) {
        return true;
      }
    }

    return false;
  }

  static bool posicionRepetida2(List<BalonOro> lista, int posicion) {
    for (final jugador in lista) {
      if (jugador.posicion == posicion) {
        return true;
      }
    }

    return false;
  }

  static List<BalonOro> listaEnumerada(List<BalonOro> lista) {
    final listaOrdenada = BalonOro.ordenar(lista);
    int numero = 1;
    for (final jugador in listaOrdenada) {
      jugador.posicion = numero;
      numero++;
    }
    return listaOrdenada;
  }
}
