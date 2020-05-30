
import 'dart:ffi';

class Note{
  int _id;
  String _title;
  String _desription;
  String _date;
  int _priority;

  Note(this._title,  this._date, this._priority,[this._desription]);

  Note.withId(this._id, this._title, this._desription, this._date,
      [this._priority]);

  int get priority => _priority;

  set priority(int value) {
    if(value>=1 && value<=2) {
      this._priority = value;
    }
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get desription => _desription;

  set desription(String value) {
    if(value.length<=255) {
      this._desription = value;

    }
  }

  String get title => _title;

  set title(String value) {
    if(value.length<=255) {
      this._title = value;
    }
  }

  int get id => _id;

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id!=null){
      map['id']= _id;

    }

    map['title']= _title;
    map['description']= _desription;
    map['date']= _date;
    map['priority']= _priority;
  }

  Note.fromMapObject(Map<String, dynamic> map){
    this._id=map['id'];
    this._title=map['title'];
    this._desription=map['description'];
    this._date=map['date'];
    this._priority=map['priority'];

  }


}