import 'package:app_censof/controllers/databasehelpers.dart';
import 'package:app_censof/main.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Project',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Project'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[
              //contenedor nombre proyecto
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'nombre',
                    hintText: 'nombre Proyecto',
                    icon: new Icon(Icons.email),
                  ),
                ),
              ),
              //contedor fecha inicio proyecto
              Container(
                height: 50,
                child: new TextField(
                  controller: _fechaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'fecha',
                    hintText: 'fecha proyecto', //marcador de agua
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),

              //contenedor para campo region
              Container(
                height: 50,
                child: new TextField(
                  controller: _regionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'region',
                    hintText: 'region', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para el campo de coordenada este
              Container(
                height: 50,
                child: new TextField(
                  controller: _provinciaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'provincia',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para el campo de coordenada norte
              Container(
                height: 50,
                child: new TextField(
                  controller: _distritoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Distrito ',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              new Padding(
                padding: new EdgeInsets.only(top: 44.0),
              ),
              /*
              Container(
                height: 50,
                child: new TextField(
                  controller: _alturaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'ALtura',
                    hintText: '',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(top: 44.0),
              ),

              */

              Container(
                height: 50,
                child: new RaisedButton(
                  onPressed: () {
                    databaseHelper.addDataProject(
                        _nameController.text.trim(),
                        _fechaController.text.trim(),
                        _regionController.text.trim(),
                        _provinciaController.text.trim(),
                        _distritoController.text.trim());
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new MainPage(),
                    ));
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Add',
                    style: new TextStyle(
                        color: Colors.white, backgroundColor: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
