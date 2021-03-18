class MateriaKardex {
  String fecEsp;
  String clvMat;
  String clvOfiMat;
  String materia;
  int cdts;
  int calif;
  String acred;
  String s1;
  String p1;
  String a1;
  String s2;
  String p2;
  String a2;

  MateriaKardex.fromDynamic(dynamic m) {
    fecEsp = m['FecEsp'];
    clvMat = m['ClvMat'];
    clvOfiMat = m['ClvOfiMat'];
    materia = m['Materia'];
    cdts = int.parse(m['Cdts'].toString());
    calif = int.parse(m['Calif'].toString());
    acred = m['Acred'];
    s1 = m['S1'];
    p1 = m['P1'];
    a1 = m['A1'];
    s2 = m['S2'];
    p2 = m['P2'];
    a2 = m['A2'];
  }
  @override
  String toString() {
    var califString = calif.toString().padLeft(3);
    return '${materia.padRight(25)}Calificación: ${califString.padRight(3)}, Acreditado: ${acred.padRight(14)}, Créditos: $cdts';
  }
}
