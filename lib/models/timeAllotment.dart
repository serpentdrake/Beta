import 'dart:convert';

List<TimeAllotment> userFromJson(String str) =>
    List<TimeAllotment>.from(json.decode(str).map((x) => TimeAllotment.fromJson(x)));

String userToJson(List<TimeAllotment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeAllotment {
  int timeId, id;
  double work, advocacy, rest;

  TimeAllotment({this.timeId, this.work, this.advocacy, this.rest, this.id});

  factory TimeAllotment.fromJson(Map<String, dynamic> json) => TimeAllotment(
    timeId: json["timeId"],
    work: json["work"],
    advocacy: json["advocacy"],
    rest: json["rest"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "timeId": timeId,
    "work": work,
    "advocacy": advocacy,
    "rest": rest,
    "id": id,
  };
}