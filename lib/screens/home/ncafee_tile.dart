import 'package:flutter/material.dart';
import 'package:want_coffee/models/preference_coffee.dart';

class NCafeeList extends StatelessWidget {
  final PreferenceCoffee ncafee;
  const NCafeeList({super.key, required this.ncafee});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        color: Colors.transparent,
        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                const AssetImage('assets/images/coffee-strength.png'),
            radius: 25.0,
            backgroundColor: Colors.brown[ncafee.strength],
          ),
          title: Text(
            ncafee.name,
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Takes ${ncafee.sugars} sugars(s)',
            style: TextStyle(
              color: Colors.grey[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
