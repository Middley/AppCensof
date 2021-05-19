import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHelper {
  //estos string son de la api
  String serverUrl = "http://192.168.1.34:8000/api";
  String serverUrlproducts = "http://192.168.1.34:8000/api/products";
  String serverUrltrees = "http://192.168.1.34:8000/api/projects/trees";
  String serverUrlprojects = "http://192.168.1.34:8000/api/projects";

  var status;

  var token;

  int dimeidProyecto(TextEditingController id) {
    return int.parse(id.text.trim());
  }

  //create function for login
  //esta funcion nos devuelve un json si todo está correcto
  loginData(String name, String password) async {
    String myUrl = "$serverUrl/login";
    final response = await http.post(Uri.parse(myUrl),
        headers: {'Accept': 'application/json'},
        body: {"name": "$name", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  //create function for register Users
  registerUserData(String name, String email, String password) async {
    String myUrl = "$serverUrl/register";
    final response = await http.post(Uri.parse(myUrl),
        headers: {'Accept': 'application/json'},
        body: {"name": "$name", "email": "$email", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

//function for register products
  void addDataProducto(String _nameController, String _priceController,
      String _stockController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    // String myUrl = "$serverUrl/api";
    String myUrl = "http://192.168.1.34:8000/api/products";
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "name": "$_nameController",
      "price": "$_priceController",
      "stock": "$_stockController"
    });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  //===============================================================
  //=========================PROJECTS==========================
  //===============================================================
  //Agregar un proyecto
  void addDataProject(
      String _nameController,
      String _fechaController,
      String _regionController,
      String _provinciaController,
      String _distritoComunController,
      int _userid) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    // String myUrl = "$serverUrl/api";
    String myUrl = "http://192.168.1.34:8000/api/projects";
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "name": "$_nameController",
      "fecha": "$_fechaController",
      "region": "$_regionController",
      "provincia": "$_provinciaController",
      "distrito": "$_regionController",
      "user_id": "$_userid"
    });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  //===============================================================
  //actualizar o editar datos del proyecto
  void editarDataProject(String id, String name, String fecha, String region,
      String provincia, String distrito, int iduser) async {
    //
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/projects/$id";
    http.put(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "fecha": "$fecha",
      "region": "$region",
      "provincia": "$provincia",
      "distrito": "$distrito",
      "user_id": "$iduser"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  //===============================================================
  //remover un proyecto
  void removeRegisterProject(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/projects/$id";
    http.delete(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  //===============================================================
  ///===================== obtener los projects ======================
  //funciton getData (obtener datos)/ va ir el interfaz principal
  Future<List> getDataProject() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrlprojects";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }

  //===============================================================
  //===============================================================
  //===============================================================
  //===============================================================
  //function REGISTRAR ARBOLES
  void addDataArboles(
      int _projectId,
      String _nombreComunController,
      String _nombreCientificoController,
      int _alturaController,
      int _coorEsteController,
      int _coorNorteComunController,
      String _observacionesController,
      String _fechaController) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    //String myUrl = "$serverUrl/api";
    String myUrl = "http://192.168.1.34:8000/api/trees";
    final response = await http.post(Uri.parse(myUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "project_id": "$_projectId",
      "nombre_comun": "$_nombreComunController",
      "nombre_cientifico": "$_nombreCientificoController",
      "altura": "$_alturaController",
      "coor_este": "$_coorEsteController",
      "coor_norte": "$_coorNorteComunController",
      "observaciones": "$_observacionesController",
      "fecha": "$_fechaController"
    });
    status = response.body.contains('error');

    var data = json.decode(response.body);

    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["token"]);
    }
  }

  //==================================================================
  // ============== actualizar datos de los arboles ==================
  //==================================================================

  void editarDataTrees(
      String id,
      String nombreComun,
      String nombreCientifico,
      String altura,
      String coorEste,
      String coorNorte,
      String observaciones,
      String fecha) async {
    //
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/trees/$id";
    http.put(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "project_id": "$id",
      "nombre_comun": "$nombreComun",
      "nombre_cientifico": "$nombreCientifico",
      "altura": "$altura",
      "coor_este": "$coorEste",
      "coor_norte": "$coorNorte",
      "observaciones": "$observaciones",
      "fecha": "$fecha"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

//=========================================================================
////===================== remover un trees ==================================
  void removeRegisterTrees(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/trees/$id";
    http.delete(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  ///
//=========================================================================
  ///===================== obtener los arboles ==============================
  //funciton getData (obtener datos)
  Future<List> getDataTrees(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/trees/$id";
    //String myUrl = "$serverUrltrees";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }
//=========================================================================
//=========================================================================
  ///

  //function for update or put (actualizar o poner)
  void editarData(String id, String name, String price, String stock) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/products/$id";
    http.put(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
      "price": "$price",
      "stock": "$stock"
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  //function for delete (eliminar)
  void removeRegister(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "http://192.168.1.34:8000/api/products/$id";
    http.delete(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  //funciton getData (obtener datos)
  Future<List> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;

    String myUrl = "$serverUrlproducts";
    http.Response response = await http.get(Uri.parse(myUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    return json.decode(response.body);
  }

  //function save (guardar)
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

//function read(leer)
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }

  //funcion para sacar el id del usuario logeado

}
