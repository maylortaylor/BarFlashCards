import 'package:barflashcards/models/drink.dart';
import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/database/dbhelper.dart';
import 'package:flutter/material.dart';

class DbSeeder {
  DbHelper _helper = DbHelper();

  static void seedDatabase(DbHelper helper) {
    List<Drink> _drinks = List<Drink>();
    var result;
    debugPrint("SEEDING database");

    // helper.initializeDb().then(
    //     (result) => helper.getDrinks().then((result) => _drinks = result));

    DateTime today = DateTime.now();

    // Cocktails
    Drink whiskey_coke = Drink(
        name: "Whiskey & Coke",
        category: DrinkCategory.Cocktail.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(whiskey_coke);
    Drink gin_tonic = Drink(
        name: "Gin & Tonic",
        category: DrinkCategory.Cocktail.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(gin_tonic);
    Drink vodka_redbull = Drink(
        name: "Vodaka & Redbull",
        category: DrinkCategory.Cocktail.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(vodka_redbull);

    // Beer
    Drink beer_ipa = Drink(
        name: "IPA",
        category: DrinkCategory.Beer.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(beer_ipa);
    Drink beer_pale_ale = Drink(
        name: "Pale Ale",
        category: DrinkCategory.Beer.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(beer_pale_ale);

    // Wine
    Drink house_red = Drink(
        name: "House Red Wine",
        category: DrinkCategory.Wine.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(house_red);
    Drink house_white = Drink(
        name: "House White Wine",
        category: DrinkCategory.Wine.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(house_white);

    // Non-Alcoholic
    Drink water = Drink(
        name: "Water",
        category: DrinkCategory.NonAlcoholic.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(water);
    Drink coca_cola = Drink(
        name: "Coca Cola",
        category: DrinkCategory.NonAlcoholic.toString(),
        dateAdded: today.toString());
    result = helper.insertDrink(coca_cola);
  }
}
