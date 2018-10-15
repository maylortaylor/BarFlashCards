import 'package:flutter/material.dart';
import 'package:barflashcards/models/drink.dart';
import 'package:barflashcards/services/firebase_firestore_service.dart';

class DrinkScreen extends StatefulWidget {
  final Drink drink;
  DrinkScreen(this.drink);

  @override
  State<StatefulWidget> createState() => new _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.drink.name);
    _descriptionController =
        new TextEditingController(text: widget.drink.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drink')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.drink.id != null) ? Text('Update') : Text('Add'),
              onPressed: () {
                if (widget.drink.id != null) {
                  db
                      .updateDrink(Drink.withId(
                          id: widget.drink.id,
                          name: _titleController.text,
                          description: _descriptionController.text))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db
                      .createDrink(
                          _titleController.text, _descriptionController.text)
                      .then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
