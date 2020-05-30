import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'notekeeper_screen.dart';
import 'dart:async';



class FunctionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Functions"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0,left: 10.0, right: 10.0),

          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text("Simple Intrest Calculator"),
                trailing: Icon(Icons.arrow_forward),
                subtitle: Text("calculate the simple intrest"),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calculator()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.assignment),
                title: Text("Notekeeper"),
                trailing: Icon(Icons.arrow_forward),
                subtitle: Text("Save your notes."),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotekeeperScreen()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
