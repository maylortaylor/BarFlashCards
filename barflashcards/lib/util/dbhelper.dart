import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/util/dbSeeder.dart';
import "package:sqflite/sqflite.dart";
import "dart:async";
import 'package:flutter/material.dart';
import "dart:io";
import "package:path_provider/path_provider.dart";
import "../models/drink.dart";

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  String tblDrinks = "drinks";
  String colId = "id";
  String colName = "name";
  String colDescription = "description";
  String colDateAdded = "dateAdded";
  String colCategory = "category";

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    debugPrint("INITIALIZING DATABASE");
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "drinks.db";
    // Delete the database
    await deleteDatabase(path);
    var dbDrinks = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbDrinks;
  }

  void _createDb(Database db, int newVersion) async {
    debugPrint("CREATING table $tblDrinks");
    await db.execute(
        "CREATE TABLE $tblDrinks($colId INTEGER PRIMARY KEY, $colName TEXT, " +
            "$colDescription TEXT, $colCategory TEXT, $colDateAdded TEXT)");

    DbSeeder.seedDatabase(_dbHelper);
  }

  Future<int> insertDrink(Drink drink) async {
    Database db = await this.db;
    var result = await db.insert(tblDrinks, drink.toMap());
    return result;
  }

  Future<List> getDrinks() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblDrinks");
    debugPrint("all drinks: " + result.toString());
    return result;
  }

  Future<List> getDrinksByCategory(DrinkCategory category) async {
    Database db = await this.db;
    var _cat = category.toString();
    var result = await db
        .rawQuery("SELECT * FROM $tblDrinks WHERE $colCategory = '$_cat'");
    debugPrint("drinks by cats: " + result.toString());
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT (*) FROM $tblDrinks"));
    return result;
  }

  Future<int> updateDrink(Drink drink) async {
    Database db = await this.db;
    var result = await db.update(tblDrinks, drink.toMap(),
        where: "$colId = ?", whereArgs: [drink.id]);
    return result;
  }

  Future<int> deleteDrink(int id) async {
    Database db = await this.db;
    var result =
        await db.rawDelete("DELETE FROM $tblDrinks WHERE $colId = $id");
    return result;
  }
}
