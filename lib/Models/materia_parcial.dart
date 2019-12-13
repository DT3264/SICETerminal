class MateriaParcial {
  static List<MateriaParcial> emptyList = [];
  List<int> califUnidades;
  String nombre;
  String grupo;
  MateriaParcial.fromDynamic(dynamic m) {
    califUnidades = [];
    nombre = m['Materia'];
    grupo = m['Grupo'];
    for (var i = 1; i <= 13; i++) {
      if (m['C${i}'] != null) {
        califUnidades.add(int.parse(m['C${i}']));
      }
    }
  }
  @override
  String toString(){
    var s = '${nombre.padRight(30)}';
    for(var i=0; i<califUnidades.length; i++){
      var califString = califUnidades[i].toString().padLeft(3);
      s+= 'U${i+1}: ${califString} ';
    }
    return s;
  }
}
