import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:want_coffee/models/user.dart';
import 'package:want_coffee/screens/authenticate/authenticate.dart';
import 'package:want_coffee/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return to either authenticate or home
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
