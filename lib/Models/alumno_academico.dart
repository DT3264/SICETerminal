class AlumnoAcademico {
  String fechaReins;
  int modEducativo;
  bool adeudo;
  String urlFoto;
  String adeudoDescripcion;
  bool inscrito;
  String estatus;
  int semActual;
  int cdtosAcumulados;
  int cdtosActuales;
  String especialidad;
  String carrera;
  int lineamiento;
  String nombre;
  String matricula;
  AlumnoAcademico.fromDynamic(dynamic a) {
    fechaReins = a['fechaReins'];
    modEducativo = int.parse(a['modEducativo'].toString());
    adeudo = a['adeudo'];
    urlFoto = a['urlFoto'];
    adeudoDescripcion = a['adeudoDescripcion'];
    inscrito = a['inscrito'];
    estatus = a['estatus'];
    semActual = int.parse(a['semActual'].toString());
    cdtosAcumulados = int.parse(a['cdtosAcumulados'].toString());
    cdtosActuales = int.parse(a['cdtosActuales'].toString());
    especialidad = a['especialidad'];
    carrera = a['carrera'];
    lineamiento = int.parse(a['lineamiento'].toString());
    nombre = a['nombre'];
    matricula = a['matricula'];
  }

  @override
  String toString() {
    var s = 'Nombre: $nombre, Matricula: $matricula, Carrera: $carrera';
    s+=', Especialidad: $especialidad, Fecha Reins: $fechaReins, ModEducativo: $modEducativo';
    s+=', UrlFoto: $urlFoto, Adeudo: $adeudo, AdeudoDescripcion: $adeudoDescripcion';
    s+=', Inscrito: $inscrito, Estatus: $estatus, SemActual: $semActual';
    s+=', CdtosActuales: $cdtosActuales, CdtosAcumulados: $cdtosAcumulados, Lineamiento: $lineamiento';
    return s;
  }
}
