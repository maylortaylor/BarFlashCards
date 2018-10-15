import 'package:barflashcards/app/cards/flash_card.dart';
import 'package:barflashcards/app/login/login_component.dart';
import 'package:barflashcards/app/home/home_component.dart';
import 'package:barflashcards/app/sections/beers.dart';
import 'package:barflashcards/app/sections/wines.dart';
import 'package:barflashcards/app/sections/nonalcoholic.dart';
import 'package:barflashcards/app/sections/cocktails.dart';
import '../helpers/color_helpers.dart';
import 'package:flutter/painting.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  debugPrint('home handler -- $params');

  return new HomeComponent();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  debugPrint('login handler -- $params');

  return new LoginComponent();
});

var winesRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  debugPrint('wines handler -- $params');
  return WinesComponent();
});

var nonAlcoholicsRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  debugPrint('non-alcoholic handler -- $params');
  return NonAlcoholicsComponent();
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
  debugPrint('cocktails handler -- $message - $color - $result');
  return CocktailsComponent(message: message, color: color, result: result);
});
var beersRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  debugPrint('beers handler -- $params');
  return BeersComponent();
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
  debugPrint('flash card handler -- $cocktail - $color - $result');
  return new FlashCardComponent(
      cocktail: cocktail, color: color, result: result);
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
