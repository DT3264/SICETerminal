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
    var dias = [
      d['Lunes'].toString(),
      d['Martes'].toString(),
      d['Miercoles'].toString(),
      d['Jueves'].toString(),
      d['Viernes'].toString(),
    ];
    horarios = {
      'Lunes': getHorarioOrEmpty(dias[0]),
      'Martes': getHorarioOrEmpty(dias[1]),
      'Miercoles': getHorarioOrEmpty(dias[2]),
      'Jueves': getHorarioOrEmpty(dias[3]),
      'Viernes': getHorarioOrEmpty(dias[4]),
    };
  }

  String getHorarioOrEmpty(String s){
    return s.isNotEmpty ?s.substring(0, 2) + ' a '+ s.substring(6, 8) : '';
  }

  @override
  String toString() {
    return '${grupo} - ${docente}\n$horarios';
  }
}
