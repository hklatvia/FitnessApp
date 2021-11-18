import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/database/db.dart';
import 'domain/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DB.init();
  runApp(AirportBase());
}

class AirportBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User1?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
          title: 'Airport',
          theme: ThemeData(
              primaryColor: Color.fromRGBO(25, 55, 65, 1),
              textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
          home: LandingPage()),
    );
  }
}
