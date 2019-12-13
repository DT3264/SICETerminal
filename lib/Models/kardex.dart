import 'package:weasprofes/Models/promedio.dart';

import 'materia_kardex.dart';

class Kardex{
  List<MateriaKardex> materias;
  Promedio promedio;
  
  Kardex.fromDynamic(dynamic k){
    materias = [];
    var objDynamic = k['d'];
    var kardexList = objDynamic['lstKardex'] as List;
    kardexList.forEach((m)=>materias.add(MateriaKardex.fromDynamic(m)));
    
    var kardexMap = objDynamic['Promedio'];
    promedio = Promedio.fromDynamic(kardexMap);
  }
}