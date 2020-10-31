import 'dart:io';
import 'package:lifemap_betav1/models/asset.dart';
import 'package:lifemap_betav1/models/surplus.dart';
import 'package:lifemap_betav1/models/timeAllotment.dart';
import 'package:lifemap_betav1/models/user.dart';
import 'package:lifemap_betav1/models/strength.dart';
import 'package:lifemap_betav1/models/weakness.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createWeak.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'lifemap.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''
              CREATE TABLE User(
                id INTEGER PRIMARY KEY,
                fName TEXT,
                lName TEXT,
                year INTEGER,
                age INTEGER,
                retireAge INTEGER,
                monthIn DOUBLE,
                productiveYear INTEGER,
                productiveHour INTEGER,
                targetRetireFund DOUBLE
               )
           ''');
          await db.execute('''
              CREATE TABLE Strength(
                strId INTEGER PRIMARY KEY,
                coreStr TEXT,
                str1 TEXT,
                str2 TEXT,
                str3 TEXT,
                str4 TEXT,
                id INTEGER,
                FOREIGN KEY (id)
                  REFERENCES User (id)
                    ON UPDATE NO ACTION
                    ON DELETE NO ACTION
              )
          ''');
          await db.execute('''
              CREATE TABLE Weakness(
                weakId INTEGER PRIMARY KEY,
                coreWeak TEXT,
                weak1 TEXT,
                weak2 TEXT,
                weak3 TEXT,
                weak4 TEXT,
                id INTEGER,
                FOREIGN KEY (id)
                  REFERENCES User (id)
                    ON UPDATE NO ACTION
                    ON DELETE NO ACTION
              )
          ''');
          await db.execute('''
              CREATE TABLE Surplus(
                cashId INTEGER PRIMARY KEY,
                cashDesc TEXT,
                cashVal DOUBLE,
                id INTEGER,
                FOREIGN KEY (id)
                  REFERENCES User (id)
                    ON UPDATE NO ACTION
                    ON DELETE NO ACTION
              )
          ''');
          await db.execute('''
              CREATE TABLE Asset(
                assetId INTEGER PRIMARY KEY,
                assetDesc TEXT,
                assetVal DOUBLE,
                id INTEGER,
                FOREIGN KEY (id)
                  REFERENCES User (id)
                    ON UPDATE NO ACTION
                    ON DELETE NO ACTION
              )
          ''');
          await db.execute('''
              CREATE TABLE TimeAllotment(
                timeId INTEGER PRIMARY KEY,
                work DOUBLE,
                advocacy DOUBLE,
                rest DOUBLE,
                id INTEGER,
                FOREIGN KEY (id)
                  REFERENCES User (id)
                    ON UPDATE NO ACTION
                    ON DELETE NO ACTION
              )
          ''');
        },
        onConfigure: (Database db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        });
  }

  // Insert employee on database
  Future<User> createUser(User user) async {
    // await deleteAllUser();
    final db = await database;
    user.id = await db.insert('User', user.toJson());

    return user;
  }

  Future<User> updateUser(User user) async {
    final db = await database;
    user.id = await db.update('User', user.toJson(), where: "id = ?", whereArgs: [user.id]);

    return user;
  }

  Future<int> deleteAllUser() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM User');

    return res;
  }

  Future<List<User>> getAllUser() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM USER");

    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromJson(c)).toList() : [];

    return list;
  }

  Future<Strength> createStr(Strength str) async {
    // await deleteAllUser();
    final db = await database;
    str.id = await db.insert('Strength', str.toJson());

    return str;
  }

  Future<Strength> updateStr(Strength str) async {
    final db = await database;
    str.strId = await db.update('Strength', str.toJson(), where: "strId = ?", whereArgs: [str.strId]);

    return str;
  }

  Future<int> deleteAllStr() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Strength');

    return res;
  }

  Future<int> deleteStr(int strId) async {
    var db = await database;
    return await db
        .delete("Strength", where: "strId = ?", whereArgs: [strId]);
  }

  Future<List<Strength>> getAllStr() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Strength");

    List<Strength> list =
    res.isNotEmpty ? res.map((c) => Strength.fromJson(c)).toList() : [];

    return list;
  }

  Future<Weakness> createWeak(Weakness weak) async {
    // await deleteAllUser();
    final db = await database;
    weak.weakId = await db.insert('Weakness', weak.toJson());

    return weak;
  }

  Future<Weakness> updateWeak(Weakness weak) async {
    final db = await database;
    weak.weakId = await db.update('Weakness', weak.toJson(), where: "weakId = ?", whereArgs: [weak.weakId]);

    return weak;
  }

  Future<int> deleteAllWeak() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Weakness');

    return res;
  }

  Future<int> deleteWeak(int weakId) async {
    var db = await database;
    return await db
        .delete("Weakness", where: "weakId = ?", whereArgs: [weakId]);
  }

  Future<List<Weakness>> getAllWeak() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Weakness");

    List<Weakness> list =
    res.isNotEmpty ? res.map((c) => Weakness.fromJson(c)).toList() : [];

    return list;
  }

  Future<Surplus> createSurplus(Surplus cash) async {
    // await deleteAllUser();
    final db = await database;
    cash.cashId = await db.insert('Surplus', cash.toJson());

    return cash;
  }

  Future<Surplus> updateSurplus(Surplus cash) async {
    final db = await database;
    cash.cashId = await db.update('Surplus', cash.toJson(), where: "cashId = ?", whereArgs: [cash.cashId]);

    return cash;
  }

  Future<int> deleteAllSurplus() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Surplus');

    return res;
  }

  Future<int> deleteSurplus(int cashId) async {
    var db = await database;
    return await db
      .delete("Surplus", where: "cashId = ?", whereArgs: [cashId]);
  }

  Future<List<Surplus>> getAllSurplus() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Surplus");

    List<Surplus> list =
    res.isNotEmpty ? res.map((c) => Surplus.fromJson(c)).toList() : [];

    return list;
  }

  Future<TimeAllotment> createTime(TimeAllotment time) async {
    // await deleteAllUser();
    final db = await database;
    time.timeId = await db.insert('TimeAllotment', time.toJson());

    return time;
  }

  Future<TimeAllotment> updateTime(TimeAllotment time) async {
    final db = await database;
    time.timeId = await db.update('TimeAllotment', time.toJson(), where: "timeId = ?", whereArgs: [time.timeId]);

    return time;
  }

  Future<int> deleteAllTime() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM TimeAllotment');

    return res;
  }


  Future<List<TimeAllotment>> getAllTime() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM TimeAllotment");

    List<TimeAllotment> list =
    res.isNotEmpty ? res.map((c) => TimeAllotment.fromJson(c)).toList() : [];

    return list;
  }

  Future<Asset> createAsset(Asset asset) async {
    // await deleteAllUser();
    final db = await database;
    asset.assetId = await db.insert('Asset', asset.toJson());

    return asset;
  }

  Future<Asset> updateAsset(Asset asset) async {
    final db = await database;
    asset.assetId = await db.update('Asset', asset.toJson(), where: "assetId = ?", whereArgs: [asset.assetId]);

    return asset;
  }

  Future<int> deleteAllAsset() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Asset');

    return res;
  }

  Future<int> deleteAsset(int assetId) async {
    var db = await database;
    return await db
        .delete("Asset", where: "assetId = ?", whereArgs: [assetId]);
  }

  Future<List<Asset>> getAllAsset() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Asset");

    List<Asset> list =
    res.isNotEmpty ? res.map((c) => Asset.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Surplus>> getCashVal() async {
    final db = await database;
    final res = await db.rawQuery("SELECT cashVal FROM Surplus");

    List<Surplus> list =
    res.isNotEmpty ? res.map((c) => Surplus.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Asset>> getAssetVal() async {
    final db = await database;
    final res = await db.rawQuery("SELECT assetVal FROM Asset");

    List<Asset> list =
    res.isNotEmpty ? res.map((c) => Asset.fromJson(c)).toList() : [];

    return list;
  }

  Future  sumCash() async {
    final db = await database;
    final res = await db.rawQuery("SELECT SUM(cashVal) FROM Surplus");


    return res;

  }


  Future tf() async {
    final db = await database;
    final res = await db.rawQuery("SELECT targetRetireFund FROM User");

    return res;
  }


}

