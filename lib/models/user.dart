import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id, age, retireAge, productiveYear, productiveHour, year;
  double targetRetireFund;
  double monthIn ;
  bool isEmployed;
  String fName, lName;

  User(
      {this.id,
      this.fName,
      this.lName,
      this.year,
      this.age,
      this.retireAge,
      this.monthIn,
      this.productiveYear,
      this.productiveHour,
      this.targetRetireFund,
      });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fName: json["fName"],
        lName: json["lName"],
        age: json["age"],
        year: json["year"],
        retireAge: json["retireAge"],
        monthIn: json["monthIn"],
        productiveYear: json["productiveYear"],
        productiveHour: json["productiveHour"],
        targetRetireFund: json["targetRetireFund"],
        // isEmployed: json["isEmployed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fName": fName,
        "lName": lName,
        "age": age,
        "year": year,
        "retireAge": retireAge,
        "monthIn": monthIn,
        "productiveYear": productiveYear,
        "productiveHour": productiveHour,
        "targetRetireFund": targetRetireFund,

        // "isEmployed": isEmployed,
      };
}
