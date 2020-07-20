import 'package:flutter/material.dart';

import 'package:uasmobile/delete.dart';
import 'package:uasmobile/get.dart';
import 'package:uasmobile/model.dart';
import 'package:uasmobile/provider.dart';
import 'package:uasmobile/put.dart';

class NomorSatu extends StatefulWidget {
  @override
  _NomorSatuState createState() => _NomorSatuState();
}

class _NomorSatuState extends State<NomorSatu> {
  PostResult postResult = null;

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: ("Nama")),
                  controller: controller1,
                ),
                TextField(
                  decoration: InputDecoration(hintText: ("Job")),
                  controller: controller2,
                ),
                TextField(
                  decoration: InputDecoration(hintText: ("Umur")),
                  controller: controller3,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("POST"),
                  onPressed: () {
                    PostResult.connecToAPI(controller1.text, controller2.text,
                            controller3.text)
                        .then((value) {
                      postResult = value;
                      setState(() {});
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("GET"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SecondPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("PUT"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PutApp();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("DELETE"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DeleteApp();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text("PROVIDER&BLOC"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NomorDua();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
