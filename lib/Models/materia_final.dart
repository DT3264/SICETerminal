class MateriaFinal{
  static List<MateriaFinal> emptyList = [];
  int calif;
  String acreditado;
  String grupo;
  String materia;
  MateriaFinal.fromDynamic(dynamic m){
    calif = int.parse(m['calif'].toString());
    acreditado = m['acred'].toString();
    grupo = m['grupo'];
    materia = m['materia'];
  }

  @override
  String toString() {
    var califString = calif.toString().padLeft(3);
    return '${materia.padRight(50)}Calificación: $califString, Acreditado: $acreditado';
  }
}