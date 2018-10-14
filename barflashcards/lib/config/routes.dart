import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/";
  static String cocktails = "/cocktails";
  static String beers = "/beers";
  static String flashCard = "/flashcard";
  // static String demoFunc = "/demo/func";
  // static String deepLink = "/message";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(beers, handler: beersRouteHandler);
    router.define(cocktails, handler: cocktailsRouteHandler);
    router.define(flashCard, handler: flashCardHandler);
    // router.define(demoSimple, handler: demoRouteHandler);
    // router.define(deepLink, handler: deepLinkHandler);
  }
}
