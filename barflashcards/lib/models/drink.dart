import 'package:meta/meta.dart';

class Drink {
  DateTime dateAdded;
  String id, name, description, category;

  Drink(
      {@required this.name,
      @required this.category,
      @required this.dateAdded,
      this.description});
  Drink.withId(
      {@required this.id,
      @required this.name,
      @required this.category,
      @required this.dateAdded,
      this.description});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["dateAdded"] = dateAdded;
    map["category"] = category;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Drink.fromObject(dynamic obj) {
    this.id = obj["id"];
    this.name = obj["name"];
    this.description = obj["description"];
    this.dateAdded = obj["dateAdded"];
    this.category = obj["category"];
  }
}
