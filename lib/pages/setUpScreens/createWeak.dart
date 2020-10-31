import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_betav1/models/weakness.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';

class createWeak extends StatefulWidget {
  final isEdit;
  final Weakness weak;

  createWeak(this.isEdit, {this.weak})
      : assert(isEdit == true || weak == null);

  @override
  _createWeakState createState() => _createWeakState();
}

class _createWeakState extends State<createWeak> {
  final formKey = new GlobalKey<FormState>();

  int weakId, id;
  String coreWeak, weak1, weak2, weak3, weak4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdit == true){
      weakId = widget.weak.weakId;
      id = widget.weak.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: Container(
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        widget.isEdit == false ? "Determine your 5 Main Weakness"
                            : "Update your 5 Main Weakness",
                        style: GoogleFonts.getFont('Alice', textStyle: TextStyle(fontSize: 20.0),
                      )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    screens(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  screens() {
    return widget.isEdit == true ? editWeakForm() : weakForm();
  }



  weakForm() {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              height: 100.0,
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                decoration: InputDecoration(
                    labelText: 'Core Weakness',
                    hintText: 'Enter your Core Weakness'
                ),
                onSaved: (val) => coreWeak = val,
              ),
            ),

            SizedBox(height: 10.0,),

            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                decoration: InputDecoration(
                    labelText: 'Weakness 1'
                ),
                onSaved: (val) => weak1 = val,
              ),
            ),
            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                decoration: InputDecoration(
                    labelText: 'Weakness 2'
                ),
                onSaved: (val) => weak2 = val,
              ),
            ),
            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                decoration: InputDecoration(
                    labelText: 'Weakness 3'
                ),
                onSaved: (val) => weak3 = val,
              ),
            ),
            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                decoration: InputDecoration(
                    labelText: 'Weakness 4'
                ),
                onSaved: (val) => weak4 = val,
              ),
            ),

            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text("Next", style: GoogleFonts.getFont('Alice'),),
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }

  editWeakForm() {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              height: 100.0,
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                initialValue: widget.weak.coreWeak,
                decoration: InputDecoration(
                    labelText: 'Core Weakness',
                    hintText: 'Enter your Core Weakness'
                ),
                onSaved: (val) => coreWeak = val,
              ),
            ),

            SizedBox(height: 10.0,),

            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                initialValue: widget.weak.weak1,
                decoration: InputDecoration(
                    labelText: 'Weakness 1'
                ),
                onSaved: (val) => weak1 = val,
              ),
            ),
            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                initialValue: widget.weak.weak2,
                decoration: InputDecoration(
                    labelText: 'Weakness 2'
                ),
                onSaved: (val) => weak2 = val,
              ),
            ),
            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                initialValue: widget.weak.weak3,
                decoration: InputDecoration(
                    labelText: 'Weakness 3'
                ),
                onSaved: (val) => weak3 = val,
              ),
            ),
            Container(
              width: 300.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0
                      ? "Field must not be empty"
                      : null;
                },
                initialValue: widget.weak.weak4,
                decoration: InputDecoration(
                    labelText: 'Weakness 4'
                ),
                onSaved: (val) => weak4 = val,
              ),
            ),

            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text("Save", style: GoogleFonts.getFont('Alice'),),
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }

  save() {
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      if(widget.isEdit == true) {
        Weakness e = Weakness(
            weakId: weakId,
            coreWeak: coreWeak,
            weak1: weak1,
            weak2: weak2,
            weak3: weak3,
            weak4: weak4,
            id: id
        );
        DBProvider.db.updateWeak(e);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage()));
      } else {
        Weakness e = Weakness(
            weakId: null,
            coreWeak: coreWeak,
            weak1: weak1,
            weak2: weak2,
            weak3: weak3,
            weak4: weak4,
            id: id
        );
        DBProvider.db.createWeak(e);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage()));
      }
    }

  }
}