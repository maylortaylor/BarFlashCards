import 'package:barflashcards/app/cards/flash_card.dart';
import 'package:barflashcards/app/sections/beers.dart';
import '../helpers/color_helpers.dart';
import '../app/sections/cocktails.dart';
import '../app/home/home_component.dart';
import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomeComponent();
});

var flashCardHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String cocktail = params["cocktail"]?.first;
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = new Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
    color = new Color(ColorHelpers.fromHexString(colorHex));
  }
  print('flash card handler -- $cocktail - $color - $result');
  return new FlashCardComponent(
      cocktail: cocktail, color: color, result: result);
});

var cocktailsRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  print('flash card handler -- $message - $color - $result');
  return CocktailsComponent(message: message, color: color, result: result);
});
var beersRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String message = params["message"]?.first;
  String colorHex = params["color_hex"]?.first;
  String result = params["result"]?.first;
  Color color = Color(0xFFFFFFFF);
  if (colorHex != null && colorHex.length > 0) {
    color = Color(ColorHelpers.fromHexString(colorHex));
  }
  print('flash card handler -- $message - $color - $result');
  return BeersComponent();
});

var demoFunctionHandler = new Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String message = params["message"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Hey Hey!",
              style: TextStyle(
                color: const Color(0xFF00D6F7),
                fontFamily: "Lazer84",
                fontSize: 22.0,
              ),
            ),
            content: Text("$message"),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 8.0, right: 8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("OK"),
                ),
              ),
            ],
          );
        },
      );
    });
