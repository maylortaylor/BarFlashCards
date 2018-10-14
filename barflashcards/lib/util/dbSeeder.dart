import 'package:barflashcards/models/drink.dart';
import 'package:barflashcards/models/drinkCategories.dart';
import 'package:barflashcards/util/dbhelper.dart';
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
        "Whiskey & Coke", DrinkCategory.Cocktail.toString(), today.toString());
    result = helper.insertDrink(whiskey_coke);
    Drink gin_tonic = Drink(
        "Gin & Tonic", DrinkCategory.Cocktail.toString(), today.toString());
    result = helper.insertDrink(gin_tonic);
    Drink vodka_redbull = Drink("Vodaka & Redbull",
        DrinkCategory.Cocktail.toString(), today.toString());
    result = helper.insertDrink(vodka_redbull);

    // Beer
    Drink beer_ipa =
        Drink("IPA", DrinkCategory.Beer.toString(), today.toString());
    result = helper.insertDrink(beer_ipa);
    Drink beer_pale_ale =
        Drink("Pale Ale", DrinkCategory.Beer.toString(), today.toString());
    result = helper.insertDrink(beer_pale_ale);

    // Wine
    Drink house_red = Drink(
        "House Red Wine", DrinkCategory.Wine.toString(), today.toString());
    result = helper.insertDrink(house_red);
    Drink house_white = Drink(
        "House White Wine", DrinkCategory.Wine.toString(), today.toString());
    result = helper.insertDrink(house_white);

    // Non-Alcoholic
    Drink water =
        Drink("Water", DrinkCategory.NonAlcoholic.toString(), today.toString());
    result = helper.insertDrink(water);
    Drink coca_cola = Drink(
        "Coca Cola", DrinkCategory.NonAlcoholic.toString(), today.toString());
    result = helper.insertDrink(coca_cola);
  }
}
