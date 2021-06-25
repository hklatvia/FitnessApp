import 'package:flutter_application_1/domain/user.dart';
import 'package:flutter_application_1/screens/auth.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User1? user = Provider.of<User1?>(context);
    final bool isLoggedIn = user != null;

    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}
