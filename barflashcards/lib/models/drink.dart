class Drink {
  int _id;
  String _name;
  String _description;
  String _dateAdded;
  String _category;

  Drink(this._name, this._category, this._dateAdded, [this._description]);
  Drink.withId(this._id, this._name, this._category, this._dateAdded,
      [this._description]);

  int get id => _id;
  String get name => _name;
  String get description => _description;
  String get dateAdded => _dateAdded;
  String get category => _category;

  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _name = newDescription;
    }
  }

  set category(String newCategory) {
    if (newCategory.length <= 25) {
      _name = newCategory;
    }
  }

  set dateAdded(String newDateAdded) {
    _dateAdded = newDateAdded;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["description"] = _description;
    map["dateAdded"] = _dateAdded;
    map["category"] = _category;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Drink.fromObject(dynamic obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._description = obj["description"];
    this._dateAdded = obj["dateAdded"];
    this._category = obj["category"];
  }
}
