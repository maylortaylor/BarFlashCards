import '../config/application.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../config/routes.dart';

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return new AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      // title: 'Bar Flash Cards',
      // theme: new ThemeData(
      //     primarySwatch: Colors.deepPurple, accentColor: Colors.blueAccent),
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
