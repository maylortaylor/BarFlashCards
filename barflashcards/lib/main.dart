import 'package:barflashcards/app/home/home_component.dart';
import 'package:barflashcards/config/application.dart';
import 'package:barflashcards/config/routes.dart';
import 'package:barflashcards/providers/perferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Preferences.prefs = await SharedPreferences.getInstance();

  Application.router = Routes.initRoutes();

  runApp(new AppComponent());
}

class AppComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
        title: "Bar Flash Cards",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        home: new HomeComponent());

    print("initial route = ${app.initialRoute}");
    return app;
  }
}
