import 'dart:convert';

List<Surplus> userFromJson(String str) =>
    List<Surplus>.from(json.decode(str).map((x) => Surplus.fromJson(x)));

String userToJson(List<Surplus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surplus{
  int cashId, id;
  double cashVal;
  String cashDesc;

  Surplus({this.cashId, this.cashDesc, this.cashVal, this.id});

  factory Surplus.fromJson(Map<String, dynamic> json) => Surplus(
    cashId: json["cashId"],
    cashDesc: json["cashDesc"],
    cashVal: json["cashVal"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'cashId': cashId,
      'cashDesc': cashDesc,
      'cashVal': cashVal,
      'id': id
    };
    return map;
  }

  Map<String, dynamic> toJson() => {
    "cashId": cashId,
    "cashDesc": cashDesc,
    "cashVal": cashVal,
    "id": id,
  };



}