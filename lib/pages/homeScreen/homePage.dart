import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifemap_betav1/models/user.dart';
import 'package:lifemap_betav1/pages/screens/timeScreen.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createStrength.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createUser.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createWeak.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';
import 'package:lifemap_betav1/screens/userInfoScreen.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


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
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Summary',
                      style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    )
                  ),
                ),

                Container(
                  height: 100.0,
                  child: summary(),
                ),
                Container(
                  child: Center(
                    child: Text(
                      'Strength',
                      style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    )
                  ),
                ),
                Container(
                  height: 80.0,
                  // width: 50.0,
                  child: Center(
                    child: coreStr(),
                  ),
                ),
                Container(
                  height: 140.0,
                  child: Center(
                    child: strList(),
                  ),
                ),

                SizedBox(height: 20,),

                Container(
                  height: 290.0,
                  width: 80.0,
                  child: Column(
                    children: [
                      Text('Time Allotment',
                        style: GoogleFonts.getFont(
                            'Alice',
                            textStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                        ),
                      ),
                      timeAllotment(),
                    ],
                  ),
                ),

                Container(
                  height: 290.0,
                  width: 80.0,
                  child: Column(
                    children: [
                      Text('Monthly Report',
                        style: GoogleFonts.getFont(
                          'Alice',
                          textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      monthlyReport(),
                    ],
                  ),
                ),

                Container(
                  height: 290.0,
                  width: 80.0,
                  child: Column(
                    children: [
                      Text('Annual Report',
                        style: GoogleFonts.getFont(
                          'Alice',
                          textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      annualReport(),
                    ],
                  ),
                ),

                Container(
                  child: Center(
                      child: Text(
                        'Weakness',
                        style: GoogleFonts.getFont('Alice', textStyle: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      )
                  ),
                ),
                Container(
                  height: 80.0,
                  // width: 50.0,
                  child: Center(
                    child: coreWeak(),
                  ),
                ),

                Container(
                  height: 140.0,
                  child: Center(
                    child: weakList(),
                  ),
                ),

                Container(
                  child: Column(
                    children: [
                      Text("Motivational Quotes", style: GoogleFonts.getFont('Alice', textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),

                      Text("\" Motivational Quote Here \" ", style: GoogleFonts.getFont('Alice', textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),)
                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      ),
    );
  }

  test(){

  }
  

  summary () {
    return FutureBuilder(
      future: DBProvider.db.getAllUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var user = snapshot.data[index];
              return new GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          Text(""),
                          Text("Monthly Expense: ${user.monthIn.toString()}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("Target Retirement Fund: ${user.targetRetireFund.toString()}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text(""),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: (){

                 // Navigator.push(context, MaterialPageRoute(builder: (context) => createUser(true, user: user,)));
                },
              );
            },
          );
        }
      },
    );
  }

  coreStr() {
    return FutureBuilder(
      future: DBProvider.db.getAllStr(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                var str = snapshot.data[index];
                return new GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70, right: 70),
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      child: Center(
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Core Strength',
                                  style: GoogleFonts.getFont(
                                    'Alice' , textStyle:TextStyle(
                                     fontSize: 20.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                                Text(
                                  '${str.coreStr}',
                                  style: GoogleFonts.getFont(
                                    'Alice',
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                  ),
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            createStrength(true, str: str,)));
                  }
                );
              },
            ),
          );
        }
      },
    );
  }

  strList() {
    return FutureBuilder(
      future: DBProvider.db.getAllStr(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              var str = snapshot.data[index];
              return new GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          Text(""),
                          Text("1. ${str.str1}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("2. ${str.str2}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("3. ${str.str3}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("4. ${str.str4}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text(""),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => createStrength(true, str: str,)));
                },
              );
            },
          );
        }
      },
    );
  }

  timeAllotment(){
    return FutureBuilder(
      initialData: [],
      future: DBProvider.db.getAllTime(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  List<PieChartSectionData> eee = List<PieChartSectionData>();
                  PieChartSectionData work = PieChartSectionData(
                      value: snapshot.data[index].work,
                      radius: 70.0,
                      title: 'Work',
                      color: Colors.redAccent
                  );
                  PieChartSectionData advocacy = PieChartSectionData(
                      value: snapshot.data[index].advocacy,
                      radius: 70.0,
                      title: 'Advocacy',
                      color: Colors.greenAccent
                  );
                  PieChartSectionData rest = PieChartSectionData(
                      value: snapshot.data[index].rest,
                      radius: 70.0,
                      title: 'Rest',
                      color: Colors.blueAccent
                  );
                  eee = [work, advocacy, rest];
                  return Container(
                    margin: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 40),
                    height: 180,
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      elevation: 10.0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  TimeSched(true, sched: snapshot.data[index],)));
                        },
                        child: PieChart(
                            PieChartData(
                                sections: eee,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0.0,
                                centerSpaceRadius: 10.0
                            )
                        ),
                      ),
                    ),
                  );
                }
            );
          }

    );

  }

  monthlyReport(){
    return FutureBuilder(
        initialData: [],
        future: DBProvider.db.getAllTime(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                List<PieChartSectionData> eee = List<PieChartSectionData>();
                PieChartSectionData work = PieChartSectionData(
                    value: snapshot.data[index].work,
                    radius: 70.0,
                    title: 'Work',
                    color: Colors.redAccent
                );
                PieChartSectionData advocacy = PieChartSectionData(
                    value: snapshot.data[index].advocacy,
                    radius: 70.0,
                    title: 'Advocacy',
                    color: Colors.greenAccent
                );
                PieChartSectionData rest = PieChartSectionData(
                    value: snapshot.data[index].rest,
                    radius: 70.0,
                    title: 'Rest',
                    color: Colors.blueAccent
                );
                eee = [work, advocacy, rest];
                return Container(
                  margin: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 40),
                  height: 180,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 10.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                TimeSched(true, sched: snapshot.data[index],)));
                      },
                      child: PieChart(
                          PieChartData(
                              sections: eee,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0.0,
                              centerSpaceRadius: 10.0
                          )
                      ),
                    ),
                  ),
                );
              }
          );
        }

    );

  }

  annualReport(){
    return FutureBuilder(
        initialData: [],
        future: DBProvider.db.getAllTime(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                List<PieChartSectionData> eee = List<PieChartSectionData>();
                PieChartSectionData work = PieChartSectionData(
                    value: snapshot.data[index].work,
                    radius: 70.0,
                    title: 'Work',
                    color: Colors.redAccent
                );
                PieChartSectionData advocacy = PieChartSectionData(
                    value: snapshot.data[index].advocacy,
                    radius: 70.0,
                    title: 'Advocacy',
                    color: Colors.greenAccent
                );
                PieChartSectionData rest = PieChartSectionData(
                    value: snapshot.data[index].rest,
                    radius: 70.0,
                    title: 'Rest',
                    color: Colors.blueAccent
                );
                eee = [work, advocacy, rest];
                return Container(
                  margin: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 40),
                  height: 180,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 10.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                TimeSched(true, sched: snapshot.data[index],)));
                      },
                      child: PieChart(
                          PieChartData(
                              sections: eee,
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0.0,
                              centerSpaceRadius: 10.0
                          )
                      ),
                    ),
                  ),
                );
              }
          );
        }

    );

  }

  coreWeak() {
    return FutureBuilder(
      future: DBProvider.db.getAllWeak(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                var weak = snapshot.data[index];
                return new GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 70, right: 70),
                      child: Card(
                        elevation: 10,
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Core Weakness',
                                    style: GoogleFonts.getFont(
                                      'Alice' , textStyle:TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ),
                                  Text(
                                      '${weak.coreWeak}',
                                      style: GoogleFonts.getFont(
                                        'Alice',
                                        textStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              createWeak(true, weak: weak,)));
                    }
                );
              },
            ),
          );
        }
      },
    );
  }

  weakList() {
    return FutureBuilder(
      future: DBProvider.db.getAllWeak(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              var weak = snapshot.data[index];
              return new GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: Card(
                    elevation: 10,
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          Text(""),
                          Text("1. ${weak.weak1}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("2. ${weak.weak2}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("3. ${weak.weak3}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text("4. ${weak.weak4}", style: GoogleFonts.getFont('Alice', textStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),),),
                          Text(""),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => createWeak(true, weak: weak,)));
                },
              );
            },
          );
        }
      },
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var dbProvider = DBProvider.db;
    await dbProvider.getAllUser();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllUser();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('Deleted');
  }
}
