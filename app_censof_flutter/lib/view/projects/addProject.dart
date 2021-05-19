import 'package:app_censof/controllers/databasehelpers.dart';
import 'package:app_censof/main.dart';
import 'package:app_censof/view/trees/listTrees.dart';
import 'package:flutter/material.dart';

class AddDataProject extends StatefulWidget {
  AddDataProject({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddDataProjectState createState() => _AddDataProjectState();
}

class _AddDataProjectState extends State<AddDataProject> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  //instanciamos
  //final TextEditingController _nameController = new TextEditingController();
  //final TextEditingController _priceController = new TextEditingController();
  //final TextEditingController _stockController = new TextEditingController();

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _fechaController = new TextEditingController();
  final TextEditingController _regionController = new TextEditingController();
  final TextEditingController _provinciaController =
      new TextEditingController();
  final TextEditingController _distritoController = new TextEditingController();
  final TextEditingController _useridController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nuevo Proyecto',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nuevo Proyecto'),
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
                  height: 20,
                ),

                buildTextField(_nameController, TextInputType.text,
                    "Nombre del proyecto", Icon(Icons.description)),
                buildTextField(_fechaController, TextInputType.text, "Fecha",
                    Icon(Icons.description)),
                buildTextField(_regionController, TextInputType.text, "Region",
                    Icon(Icons.location_city_outlined)),
                buildTextField(_provinciaController, TextInputType.text,
                    "Provincia", Icon(Icons.location_on_outlined)),
                buildTextField(_distritoController, TextInputType.text,
                    "Distrito", Icon(Icons.location_searching)),
                buildTextField(_useridController, TextInputType.number,
                    "Id Usuario", Icon(Icons.perm_identity)),

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
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => MainPage(),
                        ));
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
                          databaseHelper.addDataProject(
                              _nameController.text.trim(),
                              _fechaController.text.trim(),
                              _regionController.text.trim(),
                              _provinciaController.text.trim(),
                              _distritoController.text.trim(),
                              int.parse(_useridController.text.trim()));

                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new ListTrees(),
                          ));
                        },
                        color: Colors.lightBlue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        child: Text(
                          "Agregar",
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        icon: icono,
      ),
    );
  }
}
