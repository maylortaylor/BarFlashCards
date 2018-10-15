import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/models/user.dart';
import 'package:barflashcards/database/dbSeeder.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import "dart:async";
import 'package:flutter/material.dart';
import "dart:io";
import "package:path_provider/path_provider.dart";
import "../models/drink.dart";

class DbHelper {
  static final DbHelper _dbInstance = DbHelper._internal();
  factory DbHelper() => _dbInstance;

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      return _db;
    }
    _db = await initializeDb();
    return _db;
  }

  DbHelper._internal();

  String tblDrinks = "drinks";
  String colId = "id";
  String colName = "name";
  String colDescription = "description";
  String colDateAdded = "dateAdded";
  String colCategory = "category";

  Future<Database> initializeDb() async {
    debugPrint("INITIALIZING DATABASE ...");
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    // Delete the database
    // await deleteDatabase(path);
    var theDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return theDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    debugPrint("CREATING table $tblDrinks ...");
    await db.execute(
        "CREATE TABLE $tblDrinks($colId INTEGER PRIMARY KEY, $colName TEXT, " +
            "$colDescription TEXT, $colCategory TEXT, $colDateAdded TEXT)");

    DbSeeder.seedDatabase(_dbInstance);
  }

  // CREATEs
  Future<int> insertDrink(Drink drink) async {
    Database dbClient = await this.db;
    var result = await dbClient.insert(tblDrinks, drink.toMap());
    return result;
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  // READs
  Future<List> getDrinks() async {
    Database dbClient = await this.db;
    var result = await dbClient.rawQuery("SELECT * FROM $tblDrinks");
    debugPrint("all drinks: " + result.toString());
    return result;
  }

  Future<List> getDrinksByCategory(DrinkCategory category) async {
    Database dbClient = await this.db;
    var _cat = category.toString();
    var result = await dbClient
        .rawQuery("SELECT * FROM $tblDrinks WHERE $colCategory = '$_cat'");
    debugPrint("drinks by cats: " + result.toString());
    return result;
  }

  Future<int> getCount() async {
    Database dbClient = await this.db;
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM $tblDrinks"));
    return result;
  }

  // UPDATEs
  Future<int> updateDrink(Drink drink) async {
    Database dbClient = await this.db;
    var result = await dbClient.update(tblDrinks, drink.toMap(),
        where: "$colId = ?", whereArgs: [drink.id]);
    return result;
  }

  // DELETEs
  Future<int> deleteDrink(int id) async {
    Database dbClient = await this.db;
    var result =
        await dbClient.rawDelete("DELETE FROM $tblDrinks WHERE $colId = $id");
    return result;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  // EXTRA
  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }
}
