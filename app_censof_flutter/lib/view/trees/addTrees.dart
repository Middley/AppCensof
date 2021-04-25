import 'package:app_censof/controllers/databasehelpers.dart';
import 'package:app_censof/main.dart';
import 'package:flutter/material.dart';

class AddDataTrees extends StatefulWidget {
  AddDataTrees({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AddDataTreesState createState() => _AddDataTreesState();
}

class _AddDataTreesState extends State<AddDataTrees> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  //instanciamos
  //final TextEditingController _nameController = new TextEditingController();
  //final TextEditingController _priceController = new TextEditingController();
  //final TextEditingController _stockController = new TextEditingController();

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
          child: ListView(
            padding: const EdgeInsets.only(
                top: 62, left: 12.0, right: 12.0, bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _nombreComunController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'name',
                    hintText: 'Product name',
                    icon: new Icon(Icons.email),
                  ),
                ),
              ),
              Container(
                height: 50,
                child: new TextField(
                  controller: _nombreCientificoController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nombre científico',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),

              //para el campo altura
              Container(
                height: 50,
                child: new TextField(
                  controller: _alturaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Altura',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para el campo de coordenada este
              Container(
                height: 50,
                child: new TextField(
                  controller: _coorEsteController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'coordenada Este',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para el campo de coordenada norte
              Container(
                height: 50,
                child: new TextField(
                  controller: _coorNorteController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Coordenanda ',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para el campo observaciones
              Container(
                height: 50,
                child: new TextField(
                  controller: _coorNorteController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Coordenanda Norte',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para cmapo observaciones
              Container(
                height: 50,
                child: new TextField(
                  controller: _observacionesController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Observaciones',
                    hintText: '', //marcador de agua
                    icon: new Icon(Icons.add),
                  ),
                ),
              ),

              //para cmapo fecha
              Container(
                height: 50,
                child: new TextField(
                  controller: _fechaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Fecha',
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
                    databaseHelper.addDataArboles(
                        _nombreComunController.text.trim(),
                        _nombreCientificoController.text.trim(),
                        _alturaController.text.trim(),
                        _coorEsteController.text.trim(),
                        _coorNorteController.text.trim(),
                        _observacionesController.text.trim(),
                        _fechaController.text.trim());
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

//class _nombreCientificoController {}
