import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifemap_betav1/models/timeAllotment.dart';
import 'package:lifemap_betav1/models/user.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';

class TimeSched extends StatefulWidget {

  final bool isEdit;
  final TimeAllotment sched;

  TimeSched(this.isEdit, {this.sched})
      : assert(isEdit == true || sched == null);

  @override
  _TimeSchedState createState() => _TimeSchedState();
}

class _TimeSchedState extends State<TimeSched> {

  var works;
  var advocacy;
  var rest;
  int id;

  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.isEdit == true) {

      id = widget.sched.id;

    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text('TimeAllotment'),
            ),
            body: Column(
              children: <Widget>[
                screen()
              ],
            ),
          )
        ],
      ),
    );
  }
  form(){
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'how many hours do you work? ',
                    border: InputBorder.none
                ),
                onSaved: (val) => works = val ,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'how many hours do you have for Advocacy? ',
                    border: InputBorder.none
                ),
                onSaved: (val) => advocacy = val ,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'how many hours do you Rest? ',
                    border: InputBorder.none
                ),
                onSaved: (val) => rest = val ,
              ),
            ),
            SizedBox(height: 40,),
            Container(
              child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _save
              ),
            )

          ],
        )
    );
  }

  screen(){
    return widget.isEdit == true ? editForm() : form();
  }
  editForm(){
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              child: TextFormField(
                initialValue: widget.sched.work.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'how many hours do you work? ',
                    border: InputBorder.none
                ),
                onSaved: (val) => works = val ,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: TextFormField(
                initialValue: widget.sched.advocacy.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'how many hours do you have for Advocacy? ',
                    border: InputBorder.none
                ),
                onSaved: (val) => advocacy = val ,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: TextFormField(
                initialValue: widget.sched.rest.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'how many hours do you Rest? ',
                    border: InputBorder.none
                ),
                onSaved: (val) => rest = val ,
              ),
            ),
            SizedBox(height: 40,),
            Container(
              child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _save
              ),
            )

          ],
        )
    );
  }

  _save(){
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (widget.isEdit == true) {
        TimeAllotment e = TimeAllotment(
            timeId: id,
            work: double.parse(works.toString()),
            advocacy: double.parse(advocacy.toString()),
            rest: double.parse(rest.toString())
        );

        DBProvider.db.updateTime(e);
      }
      else {
        TimeAllotment e = TimeAllotment(
            timeId: null,
            work: double.parse(works.toString()),
            advocacy: double.parse(advocacy.toString()),
            rest: double.parse(rest.toString())
        );
        DBProvider.db.createTime(e);
      }
    }


    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => homePage()));
  }
}
