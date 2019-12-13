class Status {
  bool acceso;
  String estatus;
  int tipoUsuario;
  String pass;
  String matricula;

  Status.fromDynamic(dynamic s) {
    acceso = s['acceso'];
    estatus = s['estatus'];
    tipoUsuario = s['tipoUsuario'];
    pass = s['contrasenia'];
    matricula = s['matricula'];
  }
  @override
  String toString() {
    var s =
        'Matricula: $matricula, Estatus: $estatus, tipoUsuario: $tipoUsuario';
    s += ', Acceso: $acceso, Contraseña: $pass';
    return s;
  }
}
