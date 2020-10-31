import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_betav1/models/asset.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class assetScreen extends StatefulWidget {
  final double surplus;
  assetScreen({this.surplus});
  @override
  _assetScreenState createState() => _assetScreenState();
}

class _assetScreenState extends State<assetScreen> {
  double surplus;
  // assetScreen({this.surplus});

  final formKey = new GlobalKey<FormState>();
  TextEditingController _controllerDesc = TextEditingController();
  TextEditingController _controllerVal = TextEditingController();

  String assetDesc, assetVal;
  int assetId;





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
                        "Identify your Asset Cash",
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
                                onSaved: (val) => assetDesc = val,
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
                                onSaved: (val) => assetVal = val,
                              )),
                          Container(
                            width: 200.0,
                            child: Row(
                              children: [
                                FlatButton(onPressed: add, child: Text( isEditField == true ? 'Update' : 'Add')),
                                FlatButton(onPressed: null, child: Text('Next'))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Center(
                      child: Text(
                        "Asset Cash List",
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
        Asset e = Asset(
            assetId: null,
            assetDesc: assetDesc,
            assetVal: double.parse(assetVal)
        );
        DBProvider.db.createAsset(e);
      } else {
         Asset e = Asset(
            assetId: assetId,
            assetDesc: assetDesc,
            assetVal: double.parse(assetVal)
        );
        DBProvider.db.updateAsset(e);
      }



    }

    setState(() {
      _controllerDesc.text = "";
      _controllerVal.text = "";
      isEditField = false;
      DBProvider.db.getAllAsset();

    });
  }


  //test area ni sir.



  test()  {
    return FutureBuilder(
      initialData: [],
        future: DBProvider.db.getAssetVal(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          double total = 0.0;
          List a = [];

          for(int i = 0; i < snapshot.data.length; i++ ){
            a.add(snapshot.data[i].assetVal as double);
          }

          a.forEach((test) {total = total + test;});

          return FlatButton(
            child: Text("${total}"),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => null));
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
      initialData: [],
      future: DBProvider.db.getAllAsset(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var asset = snapshot.data[index];
              var length = snapshot.data.length;
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Cash Description: ${asset.assetDesc}", style: GoogleFonts.getFont('Alice'),),
                        Text("Cash Value: ${asset.assetVal.toString()}", style: GoogleFonts.getFont('Alice'),),
                      ],
                    ),
                    SizedBox(width: 120,),
                    IconButton(icon: Icon(Icons.edit), onPressed: (){
                      setState(() {
                        _controllerDesc.text = asset.assetDesc;
                        _controllerVal.text = asset.assetVal.toString();
                        assetId = asset.id;
                        isEditField = true;
                      });
                    }),
                    IconButton(icon: Icon(Icons.delete), onPressed: (){
                      // print([cash.cashVal]);
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
