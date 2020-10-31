import 'dart:convert';

List<Strength> userFromJson(String str) =>
    List<Strength>.from(json.decode(str).map((x) => Strength.fromJson(x)));

String userToJson(List<Strength> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Strength {
  int strId, id;
  String coreStr, str1, str2, str3, str4;

  Strength({this.strId, this.coreStr, this.str1, this.str2, this.str3, this.str4, this.id});

  factory Strength.fromJson(Map<String, dynamic> json) => Strength(
    coreStr: json["coreStr"],
    strId: json["strId"],
    str1: json["str1"],
    str2: json["str2"],
    str3: json["str3"],
    str4: json["str4"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "coreStr": coreStr,
    "strId": strId,
    "str1": str1,
    "str2": str2,
    "str3": str3,
    "str4": str4,
    "id": id,
  };
}