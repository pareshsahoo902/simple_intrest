
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:simpleintrest/models/note.dart';

class DatabaseHelper{

  static DatabaseHelper _databasehelper;
  static Database _database;

  String noteTable='note_Table';
  String colId='id';
  String colTitle='title';
  String colDescription='description';
  String colDate='date';
  String colPriority='priority';


  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if(_databasehelper!=null){
      _databasehelper= DatabaseHelper._createInstance();
    }
    return _databasehelper;
  }

  Future<Database> get database async{
    if(database!=null){
      _database = await initializeDatabse();
    }
    return database;
  }

  Future<Database> initializeDatabse() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
    
    var notesDatabse= await openDatabase(path, version: 1, onCreate: _createDB);
    return notesDatabse;
  }

  void _createDB(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colDate TEXT,'
        ' $colPriority INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getNOteMapList() async{
    Database db= await this.database;
    var result= await db.query(noteTable,orderBy: '$colPriority ASC');
    return result;

  }

  Future<int> insertNote(Note note) async{
    Database db= await this.database;
    var result= await db.insert(noteTable, note.toMap());
    return result;

  }

  Future<int> updateNote(Note note) async{
    Database db= await this.database;
    var result= await db.update(noteTable, note.toMap(),where: '$colId = ?', whereArgs: [note.id]);
    
    return result;

  }

  Future<int> deletetNote(int id) async{
    Database db= await this.database;
    int result= await db.rawDelete('DELETE FROM $noteTable WHERE $colId  = $id');

    return result;

  }


  Future<int> getCount() async{
    Database db= await this.database;
    List<Map<String, dynamic>> x =await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result= Sqflite.firstIntValue(x);
    return result;

  }

  Future<List<Note>> getNoteList() async{
    var noteMapList = await getNOteMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for( int i = 0;i< count; i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }


}