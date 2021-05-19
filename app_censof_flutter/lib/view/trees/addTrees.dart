import 'package:app_censof/controllers/databasehelpers.dart';
//import 'package:app_censof/main.dart';
import 'package:app_censof/view/trees/listTrees.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class AddDataTrees extends StatefulWidget {
  AddDataTrees({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddDataTreesState createState() => _AddDataTreesState();
}

class _AddDataTreesState extends State<AddDataTrees> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  final TextEditingController _projectIDController =
      new TextEditingController();
  final TextEditingController _nombreComunController =
      new TextEditingController();
  final TextEditingController _nombreCientificoController =
      new TextEditingController();
  final TextEditingController _alturaController = new TextEditingController();
  final TextEditingController _coorEsteController = new TextEditingController();
  final TextEditingController _coorNorteController =
      new TextEditingController();
  final TextEditingController _observacionesController =
      new TextEditingController();
  final TextEditingController _fechaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Trees',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Trees'),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                //separacion
                SizedBox(
                  height: 35,
                ),

                buildTextField(_projectIDController, TextInputType.number,
                    "Id proyecto", Icon(Icons.confirmation_number)),
                buildTextField(_nombreComunController, TextInputType.text,
                    "Nombre Común", Icon(Icons.description)),
                buildTextField(_nombreCientificoController, TextInputType.text,
                    "Nombre Cientifico", Icon(Icons.location_city_outlined)),
                buildTextField(_alturaController, TextInputType.number,
                    "Altura", Icon(Icons.center_focus_weak_outlined)),
                buildTextField(_coorEsteController, TextInputType.number,
                    "Coordenada Este", Icon(Icons.location_searching)),
                buildTextField(_coorNorteController, TextInputType.number,
                    "Coordenada Norte", Icon(Icons.location_searching)),
                buildTextField(_observacionesController, TextInputType.text,
                    "Observaciones", Icon(Icons.text_fields)),
                buildTextField(_fechaController, TextInputType.text, "Fecha",
                    Icon(Icons.date_range)),

                SizedBox(
                  height: 35,
                ),

                Row(
                  children: [
                    //BOTON CANCELAR
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => ListTrees()),
                            (Route<dynamic> route) => true);
                      },
                      child: Text(
                        "cancelar",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    //BOTON AGREGAR
                    RaisedButton(
                        onPressed: () {
                          databaseHelper.addDataArboles(
                              int.parse(_projectIDController.text.trim()),
                              _nombreComunController.text.trim(),
                              _nombreCientificoController.text.trim(),
                              int.parse(_alturaController.text.trim()),
                              int.parse(_coorEsteController.text.trim()),
                              int.parse(_coorNorteController.text.trim()),
                              _observacionesController.text.trim(),
                              _fechaController.text.trim());

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ListTrees()),
                              (Route<dynamic> route) => true);
                        },
                        color: Colors.lightBlue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        child: Text(
                          "Guardar",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField(
      TextEditingController ct, TextInputType tipo, String texto, Icon icono) {
    return TextField(
      controller: ct,
      keyboardType: tipo,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 3),
        labelText: texto,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: '',
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        icon: icono,
      ),
    );
  }
}
