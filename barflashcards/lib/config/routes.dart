import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static final Router _router = new Router();

  static String root = "/";
  static String login = "/login";
  static String cocktails = "/cocktails";
  static String beers = "/beers";
  static String wines = "/wines";
  static String nonAlcoholic = "/non-alcoholic";
  static String flashCard = "/flashcard";

  static Router initRoutes() {
    _router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    _router.define(root, handler: rootHandler);
    _router.define(login, handler: loginHandler);
    _router.define(cocktails, handler: cocktailsRouteHandler);
    _router.define(beers, handler: beersRouteHandler);
    _router.define(wines, handler: winesRouteHandler);
    _router.define(nonAlcoholic, handler: nonAlcoholicsRouteHandler);
    _router.define(flashCard, handler: flashCardHandler);

    return _router;
  }

  static void navigateTo(
      {@required context,
      @required String route,
      TransitionType transition,
      dynamic customTransition,
      Duration duration}) {
    debugPrint("Routing --> $route ----> $transition");
    _router.navigateTo(context, route,
        transition: transition,
        transitionBuilder: customTransition,
        transitionDuration:
            duration == null ? Duration(milliseconds: 600) : duration);
  }
}
