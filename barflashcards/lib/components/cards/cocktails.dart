import '../../helpers/color_helpers.dart';
import 'package:flutter/material.dart';

class CocktailsComponent extends StatelessWidget {
  CocktailsComponent(
      {String message = "Testing",
      Color color = const Color(0xFFFFFFFF),
      String result})
      : this.message = message,
        this.color = color,
        this.result = result;

  final String message;
  final Color color;
  final String result;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: color,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Padding(
            padding: new EdgeInsets.only(top: 15.0),
            child: new ConstrainedBox(
              constraints: new BoxConstraints(minHeight: 42.0),
              child: new FlatButton(
                highlightColor:
                    ColorHelpers.blackOrWhiteContrastColor(color).withAlpha(17),
                splashColor:
                    ColorHelpers.blackOrWhiteContrastColor(color).withAlpha(34),
                onPressed: () {
                  if (result == null) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context, result);
                  }
                },
                child: new Text(
                  "OK",
                  style: new TextStyle(
                    fontSize: 18.0,
                    color: ColorHelpers.blackOrWhiteContrastColor(color),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
