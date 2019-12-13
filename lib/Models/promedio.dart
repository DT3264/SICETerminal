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
    var s = 'Promedio general: $promedioGral, Créditos: $cdtsAcum de $cdtsPlan';
    s +=
        ', Materias cursadas: $matCursadas, Materias aprovadas: $matAprobadas, Porcentaje de carrera: $avanceCdts';
    return s;
  }
}
