import 'dart:async';
import 'dart:convert';

import 'package:app_censof/main.dart';
import 'package:app_censof/view/projects/detailProject.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

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
                  builder: (BuildContext context) => new DetailProject(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['name'].toString(),
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
