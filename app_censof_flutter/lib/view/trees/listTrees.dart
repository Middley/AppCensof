import 'dart:async';
import 'dart:convert';

import 'package:app_censof/controllers/databasehelpers.dart';
import 'package:app_censof/main.dart';
import 'package:app_censof/view/projects/addProject.dart';
import 'package:app_censof/view/trees/addTrees.dart';
import 'package:app_censof/view/trees/detailTrees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListTrees extends StatefulWidget {
  @override
  _ListTreesState createState() => _ListTreesState();
}

class _ListTreesState extends State<ListTrees> {
  List data;

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.34:8000/api/trees"));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("¿Quieres salir del proyecto?"),
        actions: [
          FlatButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => MainPage()),
                  (Route<dynamic> route) => true);
            },
          ),
        ],
      ),
    );
  }

  //databasehelper instancia
  DataBaseHelper databaseHelper = new DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text("Árboles"),
        ),
        body: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ItemList(list: snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),

        //boton nuevo registro arbol
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => AddDataTrees(),
              ));
            });
          },
          label: const Text('Árbol'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  //constructor
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailTrees(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['nombre_comun'].toString(),
                  style: TextStyle(fontSize: 25.0, color: Colors.blue),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
