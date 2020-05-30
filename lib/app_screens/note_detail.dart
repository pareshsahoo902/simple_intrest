
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:simpleintrest/utils/database_helper.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:simpleintrest/models/note.dart';

class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  _NoteDetailState createState() =>
      _NoteDetailState(this.note, this.appBarTitle);
}

class _NoteDetailState extends State<NoteDetail> {
  String appBarTitle;
  Note note;

  _NoteDetailState(this.note, this.appBarTitle);

  final _minimumpadding = 5.0;
  var _priority = ['HIgh', 'Low'];
  var _currentSelectedItem = 'High';
  DatabaseHelper helper = DatabaseHelper();


  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();



  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

    title.text = note.title;
    description.text = note.desription;

    return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(_minimumpadding * 2),
              child: DropdownButton<String>(
                style: textStyle,
                items: _priority.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                value: getPriorityAsString(note.priority),
                onChanged: (String newValueSelected) {
                  setState(() {
                    updatePriorityAsInt(newValueSelected);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_minimumpadding * 2),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: textStyle,
                  controller: title,
                  onChanged: (value) {
                    note.title = title.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Enter  title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)))),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: textStyle,
                  controller: description,
                  onChanged: (value) {
                    note.desription = description.text;
                  },
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter  Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)))),
            ),
            Padding(
              padding: EdgeInsets.all(_minimumpadding * 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                        child: Text(
                          "Save",
                          textScaleFactor: 1.5,

                        ),
                        elevation: 11.0,
                        color: Theme
                            .of(context)
                            .accentColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        onPressed: () {
                          _save();
                        },
                      )),
                  Container(
                    width: _minimumpadding * 2,
                  ),
                  Expanded(
                      child: RaisedButton(
                        color: Theme
                            .of(context)
                            .accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        textColor: Colors.white,
                        child: Text(
                          "Delete",
                          textScaleFactor: 1.5,
                        ),
                        elevation: 11.0,
                        onPressed: () {
                          _delete();
                        },
                      )),
                ],
              ),
            )
          ],
        ));
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priority[0];
        break;
      case 2:
        priority = _priority[1];
        break;
    }
    return priority;
  }

  void _delete() async {
    int result;
    if (note.id == null) {
      final snackbar = SnackBar(
        content: Text("no note was deleted",),);
      Scaffold.of(context).showSnackBar(snackbar);

      return;
    }

    result = await helper.deletetNote(note.id);

    Navigator.pop(context, true);
    if (result != 0) {
      final snackbar = SnackBar(
        content: Text("Note deleted",),);
      Scaffold.of(context).showSnackBar(snackbar);
    }
    else {
      final snackbar = SnackBar(
        content: Text("Some error ocuured",),);
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

  void _save() async {
    int result;
    Navigator.pop(context, true);
    note.date = DateFormat.yMMMd().format(DateTime.now());

    if (note.id != null) {
      result = await helper.updateNote(note);
    }
    else {
      result = await helper.insertNote(note);
    }
    if (result != 0) {
      final snackbar = SnackBar(
        content: Text("Note saved",),);
      Scaffold.of(context).showSnackBar(snackbar);
    }
    else {
      final snackbar = SnackBar(
        content: Text("Note saved",),);
      Scaffold.of(context).showSnackBar(snackbar);
    }
  }

}
