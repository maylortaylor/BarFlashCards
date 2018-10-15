import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/models/user.dart';
import 'package:barflashcards/database/dbSeeder.dart';
import 'package:barflashcards/utils/database_constants.dart';
import 'package:barflashcards/utils/functions.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import "dart:async";
import 'package:flutter/material.dart';
import "dart:io";
import "package:path_provider/path_provider.dart";
import "../models/drink.dart";

class DbHelper {
  static final DbHelper _dbInstance = DbHelper._internal();
  DbHelper._internal();
  factory DbHelper() => _dbInstance;

  static Database _database;
  bool didInit = false;

  static DbHelper get() {
    return _dbInstance;
  }
  Future<Database> _getDb() async {
    if (!didInit) await initializeDb();
    return _database;
  }

  Future<Database> initializeDb() async {
    debugPrint("INITIALIZING DATABASE ...");
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    // Delete the database
    // await deleteDatabase(path);
    _database = await openDatabase(path,
        version: 1, onCreate: _createDb, onUpgrade: _upgradeDb);

    didInit = true;
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    debugPrint("CREATING Database ...");
    
    await _createDrinksTable(db);
    await _createLogsTable(db);
    DbSeeder.seedDatabase(_dbInstance);
  }

  void _upgradeDb(Database db, int oldVersion, int newVersion) async {
    debugPrint("UPDATING Database ...");

    await db.execute("DROP TABLE ${DrinksTable.TABLE_NAME}");
    await db.execute("DROP TABLE ${LogsTable.TABLE_NAME}");
    await _createDrinksTable(db);
    await _createLogsTable(db);
  }

  Future _createDrinksTable(Database db) {
    debugPrint("CREATING table ${DrinksTable.TABLE_NAME} ...");

    return db.transaction((Transaction txn) async {
      txn.execute(CreateTableQueries.CREATE_DRINKS_TABLE);
    });
  }
  Future _createLogsTable(Database db) {
    debugPrint("CREATING table ${LogsTable.TABLE_NAME} ...");

    return db.transaction((Transaction txn) async {
      txn.execute(CreateTableQueries.CREATE_LOGS_TABLE);
    });
  }
  // CREATEs
  Future<int> insertDrink(Drink drink) async {
    Database dbClient = await DbHelper.get()._getDb();
    var result = await dbClient.insert(DrinksTable.TABLE_NAME, drink.toMap());
    return result;
  }

  Future<int> saveUser(User user) async {
    var dbClient = await DbHelper.get()._getDb();
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  // READs
  Future<List> getDrinks() async {
    Database dbClient = await DbHelper.get()._getDb();
    var result = await dbClient.rawQuery("SELECT * FROM ${DrinksTable.TABLE_NAME}");
    debugPrint("all drinks: " + result.toString());
    return result;
  }

  Future<List> getDrinksByCategory(DrinkCategory category) async {
    Database dbClient = await DbHelper.get()._getDb();
    var _cat = category.toString();
    var result = await dbClient
        .rawQuery("SELECT * FROM ${DrinksTable.TABLE_NAME} WHERE ${DrinksTable.CATEGORY} = '$_cat'");
    debugPrint("drinks by cats: " + result.toString());
    return result;
  }

  Future<int> getCount() async {
    Database dbClient = await DbHelper.get()._getDb();
    var result = Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT (*) FROM ${DrinksTable.TABLE_NAME}"));
    return result;
  }

  // UPDATEs
  Future<int> updateDrink(Drink drink) async {
    Database dbClient = await DbHelper.get()._getDb();
    var result = await dbClient.update(DrinksTable.TABLE_NAME, drink.toMap(),
        where: "${DrinksTable.ID} = ?", whereArgs: [drink.id]);
    return result;
  }

  // DELETEs
  Future<int> deleteDrink(int id) async {
    Database dbClient = await DbHelper.get()._getDb();
    var result =
        await dbClient.rawDelete("DELETE FROM ${DrinksTable.TABLE_NAME} WHERE ${DrinksTable.ID} = $id");
    return result;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await DbHelper.get()._getDb();
    int res = await dbClient.delete("User");
    return res;
  }

  // EXTRA

  Future<void> saveLogUsingDB(String transaction, Database db) async {
  try {
    int affectedRows =
        await db.insert("Logs", getLog(transaction).toMap());
    if (affectedRows > 0) {
//      Successful
    } else {
//      UnSuccessful
    }
  } catch (e) {
    print(e.toString());
  }
}

  Future closeDb() async {
    var dbClient = await DbHelper.get()._getDb();
    dbClient.close();
  }



  
}
