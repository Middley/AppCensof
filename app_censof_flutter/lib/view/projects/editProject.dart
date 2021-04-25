import 'package:app_censof/controllers/databasehelpers.dart';
import 'package:app_censof/view/projects/listProjects.dart';
import 'package:flutter/material.dart';

class EditProject extends StatefulWidget {
  final List list;
  final int index;

  EditProject({this.list, this.index});

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  //TextEditingController controllerName;
  //TextEditingController controllerPrice;
  //TextEditingController controllerStock;
  //TextEditingController controllerId;

  TextEditingController controllerNombre;
  TextEditingController controllerFecha;
  TextEditingController controllerRegion;
  TextEditingController controllerProvincia;
  TextEditingController controllerDistrito;
  TextEditingController controllerIdProject;

  @override
  void initState() {
    controllerIdProject = new TextEditingController(
        text: widget.list[widget.index]['id Proyecto'].toString());
    //
    controllerNombre = new TextEditingController(
        text: widget.list[widget.index]['Nombre Projecto'].toString());
    //
    controllerFecha = new TextEditingController(
        text: widget.list[widget.index]['Fecha'].toString());
    //
    controllerRegion = new TextEditingController(
        text: widget.list[widget.index]['Region'].toString());
    //
    controllerProvincia = new TextEditingController(
        text: widget.list[widget.index]['Provincia'].toString());
    //
    controllerDistrito = new TextEditingController(
        text: widget.list[widget.index]['Distrito'].toString());
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Project"),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            new Column(
              children: <Widget>[
                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.person, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerNombre,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa nombre";
                    },
                    decoration: new InputDecoration(
                      hintText: "Nombre",
                      labelText: "Nombre",
                    ),
                  ),
                ),
                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.black),
                  title: new TextFormField(
                    controller: controllerFecha,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese Fecha";
                    },
                    decoration: new InputDecoration(
                      hintText: "Fecha",
                      labelText: "Fecha",
                    ),
                  ),
                ),
                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerRegion,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa Region";
                    },
                    decoration: new InputDecoration(
                      hintText: "Fecha",
                      labelText: "Fecha",
                    ),
                  ),
                ),
                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerProvincia,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese Provincia";
                    },
                    decoration: new InputDecoration(
                      hintText: "Provincia",
                      labelText: "Provincia",
                    ),
                  ),
                ),

                //////////////////////////////////////////////
                new ListTile(
                  leading: const Icon(Icons.settings_input_component,
                      color: Colors.black),
                  title: new TextFormField(
                    controller: controllerDistrito,
                    validator: (value) {
                      if (value.isEmpty) return "Ingrese Distrito";
                    },
                    decoration: new InputDecoration(
                      hintText: "Distrito",
                      labelText: "Distrito",
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
                    databaseHelper.editarDataProject(
                      controllerIdProject.text.trim(),
                      controllerNombre.text.trim(),
                      controllerFecha.text.trim(),
                      controllerRegion.text.trim(),
                      controllerProvincia.text.trim(),
                      controllerDistrito.text.trim(),
                    );
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new ListProjects(),
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
