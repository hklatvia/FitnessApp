import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db.dart';
import 'package:flutter_application_1/database/todoitem.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:path/path.dart';

class ActiveWorkouts extends StatefulWidget {
  @override
  _ActiveWorkoutsState createState() => _ActiveWorkoutsState();
}

class _ActiveWorkoutsState extends State<ActiveWorkouts> {
  List<ToDoItem> _todo = [];

  List<Widget>? get _items => _todo.map((item) => format(item)).toList();

  String? _name;

  Widget format(ToDoItem item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Dismissible(
          key: Key(item.id.toString()),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
                shape: BoxShape.rectangle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0.0, 10))
                ]),
            child: Row(children: <Widget>[
              Expanded(
                child: Text(
                  item.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ]),
          ),
          onDismissed: (DismissDirection d) {
            DB.delete(ToDoItem.table, item);
          }),
    );
  }

  void _create(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add Workout"),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: "Workout Name"),
                    onChanged: (name) {
                      _name = name;
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(onPressed: () => _save(context), child: Text("Save"))
            ],
          );
        });
  }

  void _save(BuildContext context) async {
    Navigator.of(context).pop();
    int newId;
    if (_todo.isEmpty) {
      newId = 0;
    } else {
      newId = _todo.last.id + 1;
    }
    ToDoItem item = ToDoItem(name: _name!, id: newId);
    await DB.insert(ToDoItem.table, item);
    setState(() => _name = '');
    refresh();
  }

  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(ToDoItem.table);
    _todo = _results.map((item) => ToDoItem.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: Text(
              "Active Workouts",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            children: _items!,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => _create(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
