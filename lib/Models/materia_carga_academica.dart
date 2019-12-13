class MateriaCargaAcademica {
  static List<MateriaCargaAcademica> emptyList = [];
  String semipresencial;
  String observaciones;
  String docente;
  String clvOficial;
  String sabado;
  String viernes;
  String jueves;
  String miercoles;
  String martes;
  String lunes;
  String estadoMateria;
  int creditosMateria;
  String materia;
  String grupo;

  MateriaCargaAcademica.fromDynamic(dynamic c) {
    semipresencial = c['Semipresencial'];
    observaciones = c['Observaciones'];
    docente = c['Docente'];
    clvOficial = c['clvOficial'];
    sabado = c['Sabado'];
    viernes = c['Viernes'];
    jueves = c['Jueves'];
    miercoles = c['Miercoles'];
    martes = c['Martes'];
    lunes = c['Lunes'];
    estadoMateria = c['EstadoMateria'];
    creditosMateria = int.parse(c['CreditosMateria'].toString());
    materia = c['Materia'];
    grupo = c['Grupo'];
  }
  @override
  String toString() {
    var s = 'Materia: $materia, Docente: $docente\n';
    s += 'Lunes: ${lunes.padRight(15)}, ';
    s += 'Martes: ${martes.padRight(15)}, ';
    s += 'Miercoles. ${miercoles.padRight(15)}\n';
    s += 'Jueves: ${jueves.padRight(15)}, ';
    s += 'Viernes: ${viernes.padRight(15)}, ';
    s += 'Sabado: ${sabado.padRight(15)}';
    return s;
  }
}
