class GruposReinscripcion {
  List<GrupoReinscripcion> gruposList=[];

  GruposReinscripcion.fromDynamic(dynamic grupos) {
    grupos = grupos['GruposReinscripcion'];
    var objList = grupos as List;
    objList.forEach((o)=>gruposList.add(GrupoReinscripcion.fromDynamic(o)));
    gruposList.sort((g1, g2){
      return g1.grupo.substring(0, 3).compareTo(g2.grupo.substring(0, 3));
    });
  }
}

class GrupoReinscripcion {
  String materia;
  int materiaClave;
  String grupo;
  Map<String, String> horarios;
  String docente;
  GrupoReinscripcion.fromDynamic(dynamic d) {
    materia = d['Materia'];
    materiaClave = d['GrupoClave'];
    grupo = d['Grupo'];
    horarios = {
      'Lunes': d['Lunes'].toString(),
      'Martes': d['Martes'].toString(),
      'Miercoles': d['Miercoles'].toString(),
      'Jueves': d['Jueves'].toString(),
      'Viernes': d['Viernes'].toString(),
    };
  }
  @override
  String toString() {
    return 'Grupo: ${grupo} - Docente: ${docente}';
  }
}
