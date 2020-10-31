import 'dart:convert';

List<Weakness> userFromJson(String str) =>
    List<Weakness>.from(json.decode(str).map((x) => Weakness.fromJson(x)));

String userToJson(List<Weakness> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Weakness {
  int weakId, id;
  String coreWeak, weak1, weak2, weak3, weak4;

  Weakness({this.weakId, this.coreWeak, this.weak1, this.weak2, this.weak3, this.weak4, this.id});

  factory Weakness.fromJson(Map<String, dynamic> json) => Weakness(
    coreWeak: json["coreWeak"],
    weakId: json["weakId"],
    weak1: json["weak1"],
    weak2: json["weak2"],
    weak3: json["weak3"],
    weak4: json["weak4"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "coreWeak": coreWeak,
    "weakId": weakId,
    "weak1": weak1,
    "weak2": weak2,
    "weak3": weak3,
    "weak4": weak4,
    "id": id,
  };
}