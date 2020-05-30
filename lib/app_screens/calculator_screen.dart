import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  var _formKey = GlobalKey<FormState>();
  final _minimumpadding = 5.0;
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  var _currentSelectedItem = 'Rupees';


  var displayResult = "";

  TextEditingController pricipal = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController term = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Intrest Calculator"),
      ),
      body: Form(
        key: _formKey,
          child: Padding(
        padding: EdgeInsets.all(_minimumpadding * 2),
        child: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(_minimumpadding * 10),
                child: Image(
                  width: 150.0,
                  height: 150.0,
                  image: AssetImage(
                    "images/mon.png",
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: pricipal,
                  validator: (String Value){
                    if(Value.isEmpty){
                      return "Please enter principal";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,

                      ),
                      hintText: 'Enter principal amount e.g 12000 ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: rate,
                  validator: (String Value){
                    if(Value.isEmpty){
                      return "Please enter Rate";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Rate",
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0,

                      ),
                      hintText: 'Enter Rate e.g 5 ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: term,
                        validator: (String Value){
                          if(Value.isEmpty){
                            return "Please enter Years";
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Term",
                            labelStyle: textStyle,
                            hintText: 'Time in years',
                            errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                      ),
                    ),
                    Container(
                      width: _minimumpadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _currentSelectedItem,
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentSelectedItem = newValueSelected;
                        });
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumpadding, bottom: _minimumpadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              if(_formKey.currentState.validate()) {
                                this.displayResult = _calculatorResult();
                              }
                            });
                          },
                          elevation: 10.0,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                            textDirection: TextDirection.ltr,
                          ),
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.indigo, width: 1)),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
                    ),
                    Container(
                      width: _minimumpadding,
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        elevation: 10.0,
                        child: Text(
                          "Reset",
                          textDirection: TextDirection.ltr,
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            side: BorderSide(color: Colors.indigo, width: 1)),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumpadding, bottom: _minimumpadding),
              child: Text(
                this.displayResult,
                textDirection: TextDirection.ltr,
                style: textStyle,
              ),
            )
          ],
        ),
      )),
    );
  }

  String _calculatorResult() {
    double p = double.parse(pricipal.text);
    double r = double.parse(rate.text);
    double t = double.parse(term.text);

    double simpleIntrest = p + (p * r * t) / 100;
    String result =
        "After $t  years, your investement will be worth $simpleIntrest $_currentSelectedItem ";
    return result;
  }

  void _reset() {
    pricipal.text = "";
    rate.text = "";
    term.text = "";
    displayResult = "";
    _currentSelectedItem = _currencies[0];
  }
}
