class Promedio {
  double promedioGral;
  int cdtsAcum;
  int cdtsPlan;
  int matCursadas;
  int matAprobadas;
  double avanceCdts;

  Promedio.fromDynamic(dynamic p) {
    promedioGral = double.parse(p['PromedioGral'].toString());
    cdtsAcum = int.parse(p['CdtsAcum'].toString());
    cdtsPlan = int.parse(p['CdtsPlan'].toString());
    matCursadas = int.parse(p['MatCursadas'].toString());
    matAprobadas = int.parse(p['MatAprobadas'].toString());
    avanceCdts = double.parse(p['AvanceCdts'].toString());
  }

  @override
  String toString() {
    var str = 'Promedio general: $promedioGral\n';
    str += 'Créditos: $cdtsAcum de $cdtsPlan\n';
    str += 'Materias cursadas: $matCursadas\n';
    str += 'Materias aprovadas: $matAprobadas\n';
    str += 'Porcentaje de carrera: $avanceCdts\n';
    return str;
  }
}
