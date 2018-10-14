import 'package:barflashcards/util/dbSeeder.dart';
import 'package:barflashcards/util/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import "dart:async";
import '../config/application.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../config/routes.dart';

class AppComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;

    final app = MaterialApp(
      title: "Bar Flash Cards",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        fontFamily: 'FiraMono',
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          },
        ),
        // https://www.materialpalette.com/
        canvasColor: Colors.white,
        primaryColor: Color(0xFF3e3e3e),
        primaryColorLight: Color(0xFF3e3e3e),
        primaryColorDark: Color(0xFF3e3e3e),
        accentColor: Color(0xFFd0d0d0),
      ),
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
