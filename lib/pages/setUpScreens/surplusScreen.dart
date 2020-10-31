import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_betav1/models/surplus.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createAsset.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class surplusScreen extends StatefulWidget {
  @override
  _surplusScreenState createState() => _surplusScreenState();
}

class _surplusScreenState extends State<surplusScreen> {

  final formKey = new GlobalKey<FormState>();
  TextEditingController _controllerDesc = TextEditingController();
  TextEditingController _controllerVal = TextEditingController();

  String cashDesc, cashVal;
  int cashId;



  bool isEditField;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    isEditField = false;

    // x = await DBProvider.db.getCashVal();
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
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        "Identify your Surplus Cash",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            // height: 50.0,
                            width: 300.0,
                              child: TextFormField(
                                validator: (val) {
                                  return val.length == 0
                                      ? "Field should not be empty"
                                      : null;
                                },
                                controller: _controllerDesc,
                                decoration: InputDecoration(
                                  labelText: 'Description'
                                ),
                                onSaved: (val) => cashDesc = val,
                              )),
                          Container(
                              // height: 50.0,
                              width: 300.0,
                              child: TextFormField(
                                validator: (val) {
                                  return val.length == 0
                                      ? "Field should not be empty"
                                      : null;
                                },
                                controller: _controllerVal,
                                decoration: InputDecoration(
                                  labelText: 'Value'
                                ),
                                onSaved: (val) => cashVal = val,
                              )),
                          Container(
                            width: 200.0,
                            child: Row(
                              children: [
                                FlatButton(onPressed: add, child: Text( isEditField == true ? 'Update' : 'Add')),
                                test()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Center(
                      child: Text(
                        "Surplus Cash List",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      height: 200.0,
                      // width: 300.0,
                      child: cashList(),
                    ),
                    // cashList(),
                    // RaisedButton(child: Text('Test'),onPressed: test),
                    test()

                    // Container(
                    //   height: 100,
                    //   width: 100,
                    //   child: Column(
                    //     children: [
                    //       Text('Test Area'),
                    //       SizedBox(height: 20),
                    //       test(),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  add(){


    if(formKey.currentState.validate()){
      formKey.currentState.save();
      if(isEditField == false){
        Surplus e = Surplus(
            cashId: null,
            cashDesc: cashDesc,
            cashVal: double.parse(cashVal)
        );
        DBProvider.db.createSurplus(e);
      } else {
        Surplus e = Surplus(
            cashId: cashId,
            cashDesc: cashDesc,
            cashVal: double.parse(cashVal)
        );
        DBProvider.db.updateSurplus(e);
      }



    }

    setState(() {
      _controllerDesc.text = "";
      _controllerVal.text = "";
      isEditField = false;
      DBProvider.db.getAllSurplus();

    });
  }


  //test area ni sir.



  test()  {
    return FutureBuilder(
      initialData: [],
      future: DBProvider.db.getCashVal(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        double total = 0.0;
        List a = [];

        for(int i = 0; i < snapshot.data.length; i++ ){
          a.add(snapshot.data[i].cashVal as double);
        }

        a.forEach((test) {total = total + test;});

        return FlatButton(
          child: Text("${total}"),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => assetScreen(surplus: total,)));
          },
        );

        return Card(
          child: Text('${total}'),

        );

      });

  }





  //end of test area



  cashList() {
    return FutureBuilder(
      future: DBProvider.db.getAllSurplus(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var cash = snapshot.data[index];
              var length = snapshot.data.length;
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Cash Description: ${index}", style: GoogleFonts.getFont('Alice'),),
                        Text("Cash Value: ${cash.cashVal.toString()}", style: GoogleFonts.getFont('Alice'),),
                      ],
                    ),
                    SizedBox(width: 120,),
                    IconButton(icon: Icon(Icons.edit), onPressed: (){
                      setState(() {
                        _controllerDesc.text = cash.cashDesc;
                        _controllerVal.text = cash.cashVal.toString();
                        cashId = cash.cashId;
                        isEditField = true;
                      });
                    }),
                    IconButton(icon: Icon(Icons.delete), onPressed: (){
                      print([cash.cashVal]);
                      // DBProvider.db.deleteSurplus(cash.cashId);
                      // setState(() {
                      //   DBProvider.db.getAllSurplus();
                      // });
                    })
                  ],
                ),

              );
            },
          );
        }
      },
    );
  }
}
