import 'dart:convert';

List<Asset> userFromJson(String str) =>
    List<Asset>.from(json.decode(str).map((x) => Asset.fromJson(x)));

String userToJson(List<Asset> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Asset{
  int assetId, id;
  double assetVal;
  String assetDesc;

  Asset({this.assetId, this.assetDesc, this.assetVal, this.id});

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    assetId: json["assetId"],
    assetDesc: json["assetDesc"],
    assetVal: json["assetVal"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'assetId': assetId,
      'assetDesc': assetDesc,
      'assetVal': assetVal,
      'id': id
    };
    return map;
  }

  Map<String, dynamic> toJson() => {
    "assetId": assetId,
    "assetDesc": assetDesc,
    "assetVal": assetVal,
    "id": id,
  };



}