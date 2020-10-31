import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_betav1/models/strength.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createWeak.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';

class createStrength extends StatefulWidget {
  final isEdit;
  // final int trf;
  final Strength str;

  createStrength(this.isEdit, {this.str})
    : assert(isEdit == true || str == null);

  @override
  _createStrengthState createState() => _createStrengthState();
}

class _createStrengthState extends State<createStrength> {
  final formKey = new GlobalKey<FormState>();

  int strId, id;
  String coreStr, str1, str2, str3, str4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdit == true){
      strId = widget.str.strId;
      id = widget.str.id;
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
                        widget.isEdit == false ? "Determine your 5 Main Strengths"
                        : "Update your 5 Main Strengths",
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
    return widget.isEdit == true ? editStrForm() : strForm();
  }



  strForm() {
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
                  labelText: 'Core Strength',
                  hintText: 'Enter your Core Strength'
                ),
                onSaved: (val) => coreStr = val,
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
                  labelText: 'Strength 1'
                ),
                onSaved: (val) => str1 = val,
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
                  labelText: 'Strength 2'
                ),
                onSaved: (val) => str2 = val,
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
                    labelText: 'Strength 3'
                ),
                onSaved: (val) => str3 = val,
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
                    labelText: 'Strength 4'
                ),
                onSaved: (val) => str4 = val,
              ),
            ),

            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text("Next"),
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }

  editStrForm() {
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
                initialValue: widget.str.coreStr,
                decoration: InputDecoration(
                    labelText: 'Core Strength',
                    hintText: 'Enter your Core Strength'
                ),
                onSaved: (val) => coreStr = val,
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
                initialValue: widget.str.str1,
                decoration: InputDecoration(
                    labelText: 'Strength 1'
                ),
                onSaved: (val) => str1 = val,
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
                initialValue: widget.str.str2,
                decoration: InputDecoration(
                    labelText: 'Strength 2'
                ),
                onSaved: (val) => str2 = val,
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
                initialValue: widget.str.str3,
                decoration: InputDecoration(
                    labelText: 'Strength 3'
                ),
                onSaved: (val) => str3 = val,
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
                initialValue: widget.str.str4,
                decoration: InputDecoration(
                    labelText: 'Strength 4'
                ),
                onSaved: (val) => str4 = val,
              ),
            ),

            SizedBox(height: 20.0,),
            RaisedButton(
              child: Text("Save"),
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
        Strength e = Strength(
            strId: strId,
            coreStr: coreStr,
            str1: str1,
            str2: str2,
            str3: str3,
            str4: str4,
            id: id
        );
        DBProvider.db.updateStr(e);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage()));
      } else {
        Strength e = Strength(
            strId: null,
            coreStr: coreStr,
            str1: str1,
            str2: str2,
            str3: str3,
            str4: str4,
            id: id
        );
        DBProvider.db.createStr(e);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => createWeak(false)));
      }
    }

  }
}