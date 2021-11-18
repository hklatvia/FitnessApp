import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db.dart';
import 'package:flutter_application_1/database/flight.dart';

class ActiveWorkouts extends StatefulWidget {
  @override
  _ActiveWorkoutsState createState() => _ActiveWorkoutsState();
}

class _ActiveWorkoutsState extends State<ActiveWorkouts> {
  List<Flight> _flights = [];

  List<Widget>? get _items => _flights.map((item) => format(item)).toList();

  String? _airlineCode;
  String? _flightNumber;
  String? _departureCode;
  String? _arrivalCode;
  String? _departureTime;
  String? _arrivalTime;

  Widget format(Flight item) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Dismissible(
          key: Key(item.id.toString()),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0.0, 10))
                  ]),
              child: GestureDetector(
                child: Row(children: <Widget>[
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        _buildFlightRow("Airline code:", item.airlineCode),
                        _buildFlightRow("Flight number:", item.flightNumber),
                        _buildFlightRow("Departure code:", item.departureCode),
                        _buildFlightRow("Arrival code:", item.arrivalCode),
                        _buildFlightRow("Departure time:", item.departureTime),
                        _buildFlightRow("Arrival time:", item.arrivalTime),
                      ],
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ]),
                onTap: () {
                  _showAlertDialog(context, item);
                },
              )),
          onDismissed: (DismissDirection d) {
            DB.delete(Flight.table, item);
            refresh();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$item dismissed')));
          }),
    );
  }

  Widget _buildFlightRow(String rowTitle, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          rowTitle,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
        Text(value),
      ],
    );
  }

  void _showAlertDialog(BuildContext context, Flight? flight) {
    final String title = flight == null ? 'Add flight' : 'Edit flight';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            content: Container(
              height: 300.0,
              width: 300.0,
              child: ListView(children: <Widget>[
                ListView(
                  children: buildFields(flight),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                )
              ]),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () => _save(flight, context), child: Text("Save"))
            ],
          );
        });
  }

  Flight updateFlightWithNewInput(Flight oldFlight) {
    return Flight(
        id: oldFlight.id,
        flightNumber:
            _flightNumber != null ? _flightNumber! : oldFlight.flightNumber,
        airlineCode:
            _airlineCode != null ? _airlineCode! : oldFlight.airlineCode,
        departureCode:
            _departureCode != null ? _departureCode! : oldFlight.departureCode,
        arrivalCode:
            _arrivalCode != null ? _arrivalCode! : oldFlight.arrivalCode,
        departureTime:
            _departureTime != null ? _departureTime! : oldFlight.departureTime,
        arrivalTime:
            _arrivalTime != null ? _arrivalTime! : oldFlight.arrivalTime);
  }

  void _save(Flight? oldFlight, BuildContext context) async {
    Navigator.of(context).pop();

    Flight item;

    if (oldFlight != null) {
      item = updateFlightWithNewInput(oldFlight);
    } else {
      int newId;
      if (_flights.isEmpty) {
        newId = 0;
      } else {
        newId = _flights.last.id + 1;
      }
      item = Flight(
          id: newId,
          flightNumber: _flightNumber != null ? _flightNumber! : "",
          airlineCode: _airlineCode != null ? _airlineCode! : "",
          departureCode: _departureCode != null ? _departureCode! : "",
          arrivalCode: _arrivalCode != null ? _arrivalCode! : "",
          departureTime: _departureTime != null ? _departureTime! : "",
          arrivalTime: _arrivalTime != null ? _arrivalTime! : "");
    }

    await DB.insert(Flight.table, item);

    setState(() {
      _flightNumber = null;
      _airlineCode = null;
      _departureCode = null;
      _arrivalCode = null;
      _departureTime = null;
      _arrivalTime = null;
    });
    refresh();
  }

  void initState() {
    refresh();
    super.initState();
  }

  void refresh() async {
    List<Map<String, dynamic>> _results = await DB.query(Flight.table);
    _flights = _results.map((item) => Flight.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: ListView(children: <Widget>[
          ListView(
            children: _items!,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => _showAlertDialog(context, null),
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> buildFields(Flight? flight) {
    return <Widget>[
      TextField(
        autofocus: true,
        controller: TextEditingController()
          ..text = (flight == null ? "" : flight.airlineCode),
        decoration: InputDecoration(labelText: "Airline code"),
        onChanged: (text) {
          _airlineCode = text;
        },
      ),
      TextField(
        autofocus: true,
        controller: TextEditingController()
          ..text = (flight == null ? "" : flight.flightNumber),
        decoration: InputDecoration(labelText: "Flight number"),
        onChanged: (text) {
          _flightNumber = text;
        },
      ),
      TextField(
        autofocus: true,
        controller: TextEditingController()
          ..text = (flight == null ? "" : flight.departureCode),
        decoration: InputDecoration(labelText: "Departure code"),
        onChanged: (text) {
          _departureCode = text;
        },
      ),
      TextField(
        autofocus: true,
        controller: TextEditingController()
          ..text = (flight == null ? "" : flight.arrivalCode),
        decoration: InputDecoration(labelText: "Arrival code"),
        onChanged: (text) {
          _arrivalCode = text;
        },
      ),
      TextField(
        autofocus: true,
        controller: TextEditingController()
          ..text = (flight == null ? "" : flight.departureTime),
        decoration: InputDecoration(labelText: "Departure time"),
        onChanged: (text) {
          _departureTime = text;
        },
      ),
      TextField(
        autofocus: true,
        controller: TextEditingController()
          ..text = (flight == null ? "" : flight.arrivalTime),
        decoration: InputDecoration(labelText: "Arrival time"),
        onChanged: (text) {
          _arrivalTime = text;
        },
      ),
    ];
  }
}
