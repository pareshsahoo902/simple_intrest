import 'package:flutter/material.dart';
import 'package:simpleintrest/utils/database_helper.dart';
import 'note_detail.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:simpleintrest/models/note.dart';


class NotekeeperScreen extends StatefulWidget {
  @override
  _NotekeeperScreenState createState() => _NotekeeperScreenState();
}

class _NotekeeperScreenState extends State<NotekeeperScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> notelist;
  int count = 0;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (notelist == null) {
      notelist = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateToDetail(Note('','',2),'Add Note');
        },
      ),
    );
  }

  ListView getListView() {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          elevation: 3.0,
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(
                    this.notelist[position].priority),
                child: getPriorityIcon(this.notelist[position].priority),
              ),
              title: Text(this.notelist[position].title, style: textStyle,),
              subtitle: Text(this.notelist[position].date),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  _delete(context, notelist[position]);
                },
              ),
              onTap: (){
                navigateToDetail(this.notelist[position],'Edit Note');
              },
        ),

        );
      },
    );
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;

      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.priority_high);
        break;

      case 2:
        return Icon(Icons.assistant_photo);
        break;

      default:
        return Icon
        (Icons.assistant_photo);

        }

        }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deletetNote(note.id);
    updateListView();
    if (result != 0) {
      final snackbar = SnackBar(
        content: Text("NOte deleted", textDirection: TextDirection.ltr,),);
      Scaffold.of(context).showSnackBar(snackbar);

    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabse();
    dbFuture.then((database){
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((notelist){
        setState(() {
          this.notelist=notelist;
          this.count=notelist.length;
        });
      });
    });
  }

  void navigateToDetail(Note note, String title) async{
    bool result= await Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(note, title);
    }));
    if(result==true){
      updateListView();
    }
  }

}
