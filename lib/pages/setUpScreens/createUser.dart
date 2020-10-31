import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_betav1/models/user.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createStrength.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';
import 'dart:math' as math;

class createUser extends StatefulWidget {
  final bool isEdit;
  final User user;

  createUser(this.isEdit, {this.user})
    : assert(isEdit == true || user == null);

  @override
  _createUserState createState() => _createUserState();
}

class _createUserState extends State<createUser> {
  final formKey = new GlobalKey<FormState>();

  bool isEmployed, isEdit;
  String fName, lName, age, retireAge,  monthIn;
  int productiveYear, productiveHour, id,  year;
  double targerRetireFund,  annual, ctr;

  DateTime x = new DateTime.now();
  var month;
  var TRF;
  var annualIn;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmployed = false;
    // monthIn = '35000.00';
    month = 2000.00;
    annualIn = month * 12;
    if(x.year % 5 == 0){
      TRF = annualIn + (annualIn * 0.5);
    }
    print(x.year);
    print(x.month);
    print(TRF);

    if(widget.isEdit == true) {
      id = widget.user.id;
      year = widget.user.year;
    }
    print(widget.isEdit);

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
                    Column(
                      children: [
                        Text(
                          widget.isEdit == true ? "Update your Information" :
                          "We want to know you better",
                          style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 20.0),
                        )),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 18),
                          child: Text(
                            widget.isEdit == true ? "Please update the following" :
                            "Please fill in the following",
                            style: GoogleFonts.getFont('Alice', textStyle: TextStyle(fontSize: 15.0),
                          )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                   screens(),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  screens() {
    return widget.isEdit == true ? editForm() : form();
  }

  form() {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            //Full Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60.0,
                  width: 180.0,
                  child: TextFormField(
                    validator: (val) {
                      return val.length == 0
                          ? "Field should not be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your First Name',
                    ),
                    onSaved: (val) => fName = val,
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 180.0,
                  child: TextFormField(
                    validator: (val) {
                      return val.length == 0
                          ? "Field should not be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your Last Name',
                    ),
                    onSaved: (val) => lName = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            //Age
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0 ? "Field should not be empty" : null;
                },
                decoration: InputDecoration(
                  labelText: 'Current Age',
                ),
                onSaved: (val) => age = val,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //Retirement Age
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0 ? "Field should not be empty" : null;
                },
                initialValue: '60',
                decoration: InputDecoration(labelText: 'Retirement Age'),
                onSaved: (val) => retireAge = val,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //isEmployed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Employed',
                    style: GoogleFonts.getFont('Alice', textStyle:TextStyle(
                      fontSize: 15.0,
                    )),
                  ),
                ),
                Checkbox(
                  value: isEmployed,
                  onChanged: (val) {
                    if (isEmployed == false) {
                      setState(() {
                        isEmployed = true;
                        print(isEmployed);
                      });
                    } else if (isEmployed == true) {
                      setState(() {
                        isEmployed = false;
                        print(isEmployed);
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            //Monthly Income
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0 ? "Field should not be empty" : null;
                },
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                initialValue: '0',
                decoration: InputDecoration(
                  labelText: 'Monthly Income',
                  hintText: '0.00',
                ),
                onSaved: (val) => monthIn = val,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Next
            RaisedButton(
              elevation: 5.0,
              child: Text(
                'Next',
                style: GoogleFonts.getFont('Alice'),
              ),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  editForm() {
    return Form(
      key: formKey,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            //Full Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60.0,
                  width: 180.0,
                  child: TextFormField(
                    validator: (val) {
                      return val.length == 0
                          ? "Field should not be empty"
                          : null;
                    },
                    keyboardType: TextInputType.text,
                    // controller: _fName,
                    initialValue: widget.user.fName,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter your First Name',
                    ),
                    onSaved: (val) => fName = val,
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 180.0,
                  child: TextFormField(
                    validator: (val) {
                      return val.length == 0
                          ? "Field should not be empty"
                          : null;
                    },
                    keyboardType: TextInputType.text,
                    // controller: _lName,
                    initialValue: widget.user.lName,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter your Last Name',
                    ),
                    onSaved: (val) => lName = val,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            //Age
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0 ? "Field should not be empty" : null;
                },
                keyboardType: TextInputType.number,
                // controller: _age,
                initialValue: widget.user.age.toString(),
                decoration: InputDecoration(
                  labelText: 'Current Age',
                ),
                onSaved: (val) => age = val,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //Retirement Age
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0 ? "Field should not be empty" : null;
                },
                keyboardType: TextInputType.number,
                // controller: _retireAge,
                initialValue: widget.user.retireAge.toString(),
                decoration: InputDecoration(labelText: 'Retirement Age'),
                onSaved: (val) => retireAge = val,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            //isEmployed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Employed',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Checkbox(
                  value: isEmployed,
                  onChanged: (val) {
                    if (isEmployed == false) {
                      setState(() {
                        isEmployed = true;
                        print(isEmployed);
                      });
                    } else if (isEmployed == true) {
                      setState(() {
                        isEmployed = false;
                        print(isEmployed);
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            //Monthly Income
            Container(
              height: 60.0,
              width: 200.0,
              child: TextFormField(
                validator: (val) {
                  return val.length == 0 ? "Field should not be empty" : null;
                },
                keyboardType: TextInputType.number,
                // controller: _monthIn,
                initialValue: widget.user.monthIn.toString(),
                inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                // initialValue: '0',
                decoration: InputDecoration(
                  labelText: 'Monthly Income',
                  hintText: '0.00',
                ),
                onSaved: (val) => monthIn = val,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //Next
            RaisedButton(
              elevation: 5.0,
              child: Text(
                'Save',
                style: GoogleFonts.getFont('Alce'),
              ),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  _save() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      productiveYear = int.parse(retireAge) - int.parse(age);
      print(productiveYear);
      productiveHour = productiveYear * 12 * 26 * 8;
      print(productiveHour);
      // targerRetireFund = double.parse(monthIn) * 2;
      ctr = productiveYear / 5;
      annual = double.parse(monthIn) * 12;
      targerRetireFund = math.pow(annual, ctr.toInt());
      if(widget.isEdit == true){


        User e = User(
          id: id,
          fName: fName,
          lName: lName,
          year: year,
          age: int.parse(age),
          retireAge: int.parse(retireAge),
          monthIn: double.parse(monthIn),
          productiveYear: productiveYear,
          productiveHour: productiveHour,
          targetRetireFund: targerRetireFund,
        );
        DBProvider.db.updateUser(e);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homePage()));
      } else {
        year = x.year;

        User e = User(
          id: null,
          fName: fName,
          lName: lName,
          year: year,
          age: int.parse(age),
          retireAge: int.parse(retireAge),
          monthIn: double.parse(monthIn),
          productiveYear: productiveYear,
          productiveHour: productiveHour,
          targetRetireFund: targerRetireFund,
        );
        DBProvider.db.createUser(e);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => createStrength(false)));
      }

    }
  }
}


class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
