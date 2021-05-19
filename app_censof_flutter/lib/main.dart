import 'dart:convert';

import 'package:app_censof/view/login.dart';
import 'package:app_censof/view/projects/addProject.dart';
import 'package:app_censof/view/projects/detailProject.dart';
import 'package:app_censof/view/trees/listTrees.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App censo flutter",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(accentColor: Colors.white70),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  List data;

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.34:8000/api/projects"));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
    checkLoginStatus();
  }

  //=============================================================

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  //
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("¿Quiere salir de la aplicación?"),
        actions: [
          FlatButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  ///
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "APP CENSOF",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        body: Container(
          child: FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ItemList(list: snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => AddDataProject(),
              ));
            });
          },
          label: const Text('Proyecto'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),

        //
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('Middley'),
                accountEmail: new Text('935477087'),
                // decoration: new BoxDecoration(
                //   image: new DecorationImage(
                //     fit: BoxFit.fill,
                //    // image: AssetImage('img/estiramiento.jpg'),
                //   )
                // ),
              ),
              new Divider(),
              new ListTile(
                title: new Text("Datos"),
                trailing: new Icon(Icons.face),
              ),
              /*
              new ListTile(
                title: new Text("List Products"),
                trailing: new Icon(Icons.help),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ListProducts(),
                )),
              ),
              new ListTile(
                title: new Text("Add Products"),
                trailing: new Icon(Icons.help),
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => AddDataProduct(),
                )),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

//clase para listar
class ItemList extends StatelessWidget {
  final List list;
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
                  builder: (BuildContext context) => new ListTrees()),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['name'].toString(),
                  style: TextStyle(fontSize: 23.0, color: Colors.blue),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemListDraw extends StatelessWidget {
  final List list;
  ItemListDraw({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (context, i) {
            Container(
              child: new GestureDetector(
                onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new ListTrees()),
                ),
                child: new Card(
                  child: new ListTile(
                    title: new Text(
                      list[i]['name'].toString(),
                      style:
                          TextStyle(fontSize: 25.0, color: Colors.orangeAccent),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/*
class ListProjects extends StatefulWidget {
  @override
  _ListProjectsState createState() => _ListProjectsState();
}

class _ListProjectsState extends State<ListProjects> {
  List data;

  Future<List> getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.34:8000/api/projects"));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews Projects"),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
*/
