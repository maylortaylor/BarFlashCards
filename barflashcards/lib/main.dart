import 'package:barflashcards/providers/perferences.dart';

import 'app/app_component.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Preferences.prefs = await SharedPreferences.getInstance();

  runApp(new AppComponent());
}
