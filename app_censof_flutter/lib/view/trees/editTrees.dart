import 'package:app_censof/controllers/databasehelpers.dart';
import 'package:app_censof/view/trees/listTrees.dart';
import 'package:flutter/material.dart';

class EditTrees extends StatefulWidget {
  final List list;
  final int index;

  EditTrees({this.list, this.index});

  @override
  _EditTreesState createState() => _EditTreesState();
}

class _EditTreesState extends State<EditTrees> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  //TextEditingController controllerName;
  //TextEditingController controllerPrice;
  //TextEditingController controllerStock;
  //TextEditingController controllerId;

  TextEditingController controllerNombreComun;
  TextEditingController controllerNombreCientifico;
  TextEditingController controllerAltura;
  TextEditingController controllerCoorEste;
  TextEditingController controllerCoorNorte;
  TextEditingController controllerObservaciones;
  TextEditingController controllerfecha;
  TextEditingController controllerIdTrees;

  @override
  void initState() {
    controllerIdTrees = new TextEditingController(
        text: widget.list[widget.index]['id Proyecto'].toString());
    //
    controllerNombreComun = new TextEditingController(
        text: widget.list[widget.index]['Nombre Comun'].toString());
    //
    controllerNombreCientifico = new TextEditingController(
        text: widget.list[widget.index]['Nombre Cientifico'].toString());
    //
    controllerAltura = new TextEditingController(
        text: widget.list[widget.index]['Altura'].toString());
    //
    controllerCoorEste = new TextEditingController(
        text: widget.list[widget.index]['C. Este'].toString());
    //
    controllerCoorNorte = new TextEditingController(
        text: widget.list[widget.index]['C. Norte'].toString());
    //
    controllerObservaciones = new TextEditingController(
        text: widget.list[widget.index]['Observaciones'].toString());
    //
    controllerfecha = new TextEditingController(
        text: widget.list[widget.index]['Fecha'].toString());
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Trees"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerNombreComun,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre comun";
                    },
                    decoration: new InputDecoration(
                      hintText: "Nombre Comun",
                      labelText: "Nombre Comun",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerNombreCientifico,
                    validator: (value) {
                      if (value.isEmpty) return "Nombre cientifico";
                    },
                    decoration: new InputDecoration(
                      hintText: "Nombre Comun",
                      labelText: "Nombre Comun",
                    ),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerAltura,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa Altura";
                    },
                    decoration: new InputDecoration(
                      hintText: "Altura",
                      labelText: "Altura",
                    ),
                  ),
                ),
                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerCoorEste,
                    validator: (value) {
                      if (value.isEmpty) return "C. Este";
                    },
                    decoration: new InputDecoration(
                      hintText: "C. Este",
                      labelText: "C. Este",
                    ),
                  ),
                ),

                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerCoorNorte,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese C.Norte";
                    },
                    decoration: new InputDecoration(
                      hintText: "C.Norte",
                      labelText: "C.Norte",
                    ),
                  ),
                ),

                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerObservaciones,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa Observaciones";
                    },
                    decoration: new InputDecoration(
                      hintText: "Observaciones",
                      labelText: "Observaciones",
                    ),
                  ),
                ),

                ////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerfecha,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa Fecha";
                    },
                    decoration: new InputDecoration(
                      hintText: "Fecha",
                      labelText: "Fecha",
                    ),
                  ),
                ),

                //////////////////////////////////////////////
                //////////////////////////////////////////////
                const Divider(
                  height: 1.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),

                ////////////////////////////////////

                new RaisedButton(
                  child: new Text("Edit"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    databaseHelper.editarDataTrees(
                        controllerIdTrees.text.trim(),
                        controllerNombreComun.text.trim(),
                        controllerNombreCientifico.text.trim(),
                        controllerAltura.text.trim(),
                        controllerCoorEste.text.trim(),
                        controllerCoorNorte.text.trim(),
                        controllerObservaciones.text.trim(),
                        controllerfecha.text.trim());
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new ListTrees(),
                    ));
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
