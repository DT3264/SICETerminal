import 'dart:io';
import 'package:weasprofes/webservice_alumnos.dart';

WebServiceAlumnos wsA = WebServiceAlumnos();
void main(List<String> args) async {
  var user = '';
  var pass = '';
  if(args.isEmpty){
    print('Ingrese su usuario: ');
    user = stdin.readLineSync();
    print('Ingrese su contraseña: ');
    pass = stdin.readLineSync();
  }
  else{
    user = args[0];
    pass = args[1];
  }
  await login(user, pass);
  var opt = 1;
  print('\n***********************\n');
  do {
    printMenu();
    try {
      opt = int.tryParse(stdin.readLineSync().trim());
    } on FormatException {
      print('Opción inválida');
    }
    print('\n***********************');
    await handleOpt(opt);
    print('\n***********************\n');
  }while(opt!=0);
}

void login(String user, String pass) async {
  var s = await wsA.login(user, pass);
  if (!s.acceso) {
    print('Usuario o contraseña incorrectos');
    exit(0);
  }
}

void printMenu() {
  print('Ingrese una opción');
  print('1: Calificaciones parciales');
  print('2: Calificaciones finales');
  print('3: Kardex');
  print('4: Carga académica');
  print('5: Promedio general');
  print('6: Materias disponibles para inscripción');
  print('0: Salir');
}

void handleOpt(int opt) async{
  if (opt == 1) {
    await getParciales();
  } else if (opt == 2) {
    await getFinales();
  } else if (opt == 3) {
    await getKardex();
  } else if (opt == 4) {
    await getCargaAcademica();
  } else if (opt == 5) {
    await getPromedio();
  } else if (opt == 6) {
    await getGruposAInscribir();
  } else if(opt == 0){
    print('\nCerrando');
  }
}

void getParciales() async {
  print('\nCalificaciones parciales');
  var califParcial = await wsA.califParciales();
  if (califParcial.isNotEmpty) {
    califParcial.forEach((f) => print(f));
  } else {
    print('No hay calificaciones a mostrar\n');
  }
}

void getFinales() async {
  print('\nCalificaciones finales');
  var califFinal = await wsA.califFinales();
  if (califFinal.isNotEmpty) {
    califFinal.forEach((f) => print(f));
  } else {
    print('No hay calificaciones a mostrar\n');
  }
}

void getKardex() async {
  print('\nKardex ');
  var kardex = await wsA.kardexConPromedio();
  print(kardex.promedio);
  kardex.materias.forEach((m) => print(m));
}

void getCargaAcademica() async {
  print('\nCarga Academica');
  var cargaAcademica = await wsA.getCargaAcademica();
  cargaAcademica.forEach((m) => print(m.toString() + '\n'));
}

void getPromedio() async {
  print('\nPromedio General');
  var promedioGeneral = await wsA.getPromedioDetalle();
  print(promedioGeneral);
}

Future<void> getGruposAInscribir() async {
  print('Ingrese el número del semestre an inscribirse:');
  var nextSemestre = int.parse(stdin.readLineSync());
  print('Grupos a inscribir');
  var grupos = await wsA.getGruposAInscribirByAlumno(nextSemestre);
  if (grupos.isNotEmpty) {
    for(var i=0; i<grupos.length; i++){
      grupos[i].docente = await wsA.getDocente(grupos[i].materiaClave);
      print(grupos[i]);
    }
  } else {
    print('No hay grupos para inscribirse actualmente');
  }
}
