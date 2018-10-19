import 'package:barflashcards/app/settings/color_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:io";
import 'package:flutter/material.dart';

class AppSettings {
  static final AppSettings _appSettings = AppSettings._internal();
  AppSettings._internal();
  factory AppSettings() => _appSettings;

  static SharedPreferences _preferences;
  bool hasBeenInitialized = false;

  static AppSettings get() {
    return _appSettings;
  }

  Future<SharedPreferences> _getPreferences() async {
    if (!hasBeenInitialized) await initializePreferences();
    return _preferences;
  }

  Future<SharedPreferences> initializePreferences() async {
    debugPrint("INITIALIZING PREFERENCES ...");

    _preferences = await SharedPreferences.getInstance();
    _preferences.setString('color', ColorSetting.Dark.toString());
    hasBeenInitialized = true;
  }

  Future<Color> setColorSetting(ColorSetting color) async {
    _preferences = await AppSettings.get()._getPreferences();
    _preferences.setString('color', color.toString());
    return getColorSettings();
  }

  Future<Color> getColorSettings() async {
    _preferences = await AppSettings.get()._getPreferences();
    final colorSetting = _preferences.getString('color');
    debugPrint("app_settings --> getColorSettings --> $colorSetting");
    switch (colorSetting) {
      case 'ColorSetting.Dark':
        debugPrint('setting black');
        return Colors.black45;
        break;
      case 'ColorSetting.Light':
        debugPrint('setting light');
        return Colors.white54;
        break;
      case 'ColorSetting.Hot':
        debugPrint('setting hot');
        return Colors.red;
        break;
      case 'ColorSetting.Cool':
        debugPrint('setting lightblue');
        return Colors.lightBlue;
        break;
    }
    debugPrint('setting pink');
    return Colors.pink;
  }
}
