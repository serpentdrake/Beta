import 'package:flutter/material.dart';
import 'package:lifemap_betav1/pages/homeScreen/homePage.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createUser.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';

class wrapper extends StatefulWidget {
  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBProvider.db.getAllUser();
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
            body: FutureBuilder(
              future: DBProvider.db.getAllUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                return RaisedButton(
                  child: Text("Click Me"),
                  onPressed: (){
                    if(snapshot.data.length == 0){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => createUser(false)));
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePage()));
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
