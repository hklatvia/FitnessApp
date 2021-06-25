// ignore: import_of_legacy_library_into_null_safe
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/active-workouts.dart';
import 'package:flutter_application_1/components/workots-list.dart';
import 'package:flutter_application_1/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    /* var navigationBar = CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search),
      ],
      index: 0,
      height: 50,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.5),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index) {
        setState(() => sectionIndex = index);
      },
    );*/

    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('FunnyFat //' +
              (sectionIndex == 0 ? 'Active Workouts' : 'Find Workouts')),
          leading: Icon(Icons.fitness_center),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton.icon(
                onPressed: () {
                  AuthService().logOut();
                },
                icon: Icon(
                  Icons.supervised_user_circle_outlined,
                  color: Colors.white,
                ),
                label: SizedBox.shrink())
          ],
        ),
        body: sectionIndex == 0 ? ActiveWorkouts() : WorkoutsList(),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.fitness_center,
                ),
                label: 'My Workouts',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: 'Find Workouts',
              )
            ],
            currentIndex: sectionIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.white60,
            onTap: (int index) {
              setState(() => sectionIndex = index);
            }),
      ),
    );
  }
}
