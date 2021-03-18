import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:weasprofes/Models/alumno_academico.dart';
import 'package:weasprofes/Models/kardex.dart';
import 'package:weasprofes/Models/materia_carga_academica.dart';
import 'package:weasprofes/Models/materia_final.dart';
import 'package:weasprofes/Models/materia_parcial.dart';
import 'package:weasprofes/Models/grupos_reinscripcion.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:weasprofes/Models/promedio.dart';
import 'package:weasprofes/Models/status.dart';
import 'package:xml2json/xml2json.dart';

import 'Models/grupos_reinscripcion.dart';

class WebServiceAlumnos {
  var url = 'https://sicenet.itsur.edu.mx/WS/WSAlumnos.asmx';
  var urlDocentes = 'https://sicenet.itsur.edu.mx/WS/WSDocentes.asmx';
  //var url = 'http://localhost:55786/SICE-NET/WS/WSAlumnos.asmx';
  //var urlDocentes = 'http://localhost:55786/SICE-NET/WS/WSDocentes.asmx';
  final dioClient = Dio();
  final cookieJar = CookieJar();

  Future<Status> login(String user, String pass) async {
    dioClient.interceptors.add(CookieManager(cookieJar));
    var subUrl = 'accesoLogin';
    var data = {
      'strMatricula': user,
      'strContrasenia': pass,
      'tipoUsuario': '0'
    };
    var fullUrl = '${url}/${subUrl}';
    //Petición inicial para obtener una cookie válida
    var response = await dioClient.get(
        fullUrl + '?strMatricula=${user}&strContrasenia=${pass}&tipoUsuario=0');
    //Ahora con la cookie, podemos hacer peticiones
    response = await dioClient.post(fullUrl, data: data);

    var jsonData = response.data;
    var jsonString = jsonData['d'];
    Status status;
    if (jsonString != '') {
      jsonData = json.decode(jsonString);
      status = Status.fromDynamic(jsonData);
    } else {
      status = Status.fromDynamic({'acceso': false});
    }
    return status;
  }

  Future<List<MateriaParcial>> califParciales() async {
    var subUrl = 'getCalifUnidadesByAlumno';
    var response = await dioClient.post('${url}/${subUrl}');
    var responseData = response.data as String;
    //print(responseData);
    var jsonObj = getJsonFromXml(responseData);
    var jsonString = jsonObj['string']['\$'].toString();
    jsonString = jsonString.replaceAll('\\r\\n', '');
    jsonObj = json.decode(jsonString);
    var objList = jsonObj as List;
    var materiasList = MateriaParcial.emptyList;
    materiasList.clear();
    if (objList != null) {
      objList.forEach((m) => materiasList.add(MateriaParcial.fromDynamic(m)));
    }
    materiasList.sort((m1, m2) => m1.nombre.compareTo(m2.nombre));
    return materiasList;
  }

  Future<List<MateriaFinal>> califFinales() async {
    var subUrl = 'getAllCalifFinalByAlumnos';
    var data = {'bytModEducativo': '0'};
    var response = await dioClient.post('${url}/${subUrl}', data: data);
    var responseData = response.data.toString();
    responseData = responseData.replaceAll('{d: [', '[');
    responseData = responseData.replaceAll(']}', ']');
    var materiasList = MateriaFinal.emptyList;
    if (!responseData.contains('d:')) {
      var jsonObj = json.decode(responseData);
      var objList = jsonObj as List;
      materiasList.clear();
      objList.forEach((m) => materiasList.add(MateriaFinal.fromDynamic(m)));
      materiasList.sort((m1, m2) => m1.materia.compareTo(m2.materia));
    }
    return materiasList;
  }

  Future<Kardex> kardexConPromedio() async {
    var subUrl = 'getAllKardexConPromedioByAlumno';
    var data = {'aluLineamiento': '1'};
    var response = await dioClient.post('${url}/${subUrl}', data: data);
    var responseData = response.data.toString();
    responseData = responseData.replaceFirst('d', '\"d\"');
    var jsonObj = json.decode(responseData);
    var kardex = Kardex.fromDynamic(jsonObj);
    return kardex;
  }

  Future<AlumnoAcademico> getAlumnoAcademicoWithLineamiento() async {
    var subUrl = 'getAlumnoAcademicoWithLineamiento';
    var response = await dioClient.post('${url}/${subUrl}');
    var jsonObj = getJsonFromXml(response.data);
    jsonObj = json.decode(jsonObj['string']['\$']);
    var alumno = AlumnoAcademico.fromDynamic(jsonObj);
    return alumno;
  }

  Future<List<MateriaCargaAcademica>> getCargaAcademica() async {
    var subUrl = 'getCargaAcademicaByAlumno';
    var response = await dioClient.post('${url}/${subUrl}');
    var jsonObj = getJsonFromXml(response.data);
    var jsonString = jsonObj['string']['\$'].toString();
    jsonString = jsonString.replaceAll('\\r\\n', '');
    jsonObj = json.decode(jsonString);
    var objList = jsonObj as List;
    var materiasCarga = MateriaCargaAcademica.emptyList;
    materiasCarga.clear();
    if (objList != null) {
      objList.forEach(
          (m) => materiasCarga.add(MateriaCargaAcademica.fromDynamic(m)));
      materiasCarga.sort((m1, m2) => m1.materia.compareTo(m2.materia));
    }
    return materiasCarga;
  }

  Future<Promedio> getPromedioDetalle() async {
    var subUrl = 'getPromedioDetalleByAlumno';
    var response = await dioClient.post('${url}/${subUrl}');
    var jsonObj = getJsonFromXml(response.data);
    jsonObj = json.decode(jsonObj['string']['\$']);
    var promedio = Promedio.fromDynamic(jsonObj);
    return promedio;
  }

  Future<Map<dynamic, dynamic>> getGruposAInscribirByAlumno(
      int nextSemestre) async {
    var subUrl = 'getGruposAInscribirByAlumno';
    var response = await dioClient
        .post('${url}/${subUrl}', data: {'bytSemAInscribir': nextSemestre});
    var jsonString = response.data['d'];
    if (jsonString != '') {
      var jsonObj = json.decode(jsonString);
      var grupos = GruposReinscripcion.fromDynamic(jsonObj);
      for (var grupo in grupos.gruposList) {
        grupo.docente = await getDocente(grupo.materiaClave);
      }
      var materias = {};
      for (var grupo in grupos.gruposList) {
        if (materias.containsKey(grupo.materia)) {
          materias[grupo.materia].add(grupo);
        }
        materias.putIfAbsent(grupo.materia, () => [grupo]);
      }
      return materias;
    }
    return {};
  }

  Future<String> getDocente(int claveGrupo) async {
    var subUrl = 'getListaGrupo';
    var response = await dioClient
        .post('${urlDocentes}/${subUrl}', data: {'claveGrupo': claveGrupo});
    var jsonString = response.data['d'];
    var jsonObj = json.decode(jsonString);
    var docente = jsonObj['listaGrupoEsquema']['Docente'];
    return docente;
  }

  dynamic getJsonFromXml(String responseData) {
    var tokenize = Xml2Json();
    tokenize.parse(responseData);
    var jsonStr = tokenize.toBadgerfish();
    var jsonObj = json.decode(jsonStr);
    return jsonObj;
  }
}
