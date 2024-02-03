import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:want_coffee/models/preference_coffee.dart';
import 'package:want_coffee/screens/home/ncafee_tile.dart';

class NCaffeeList extends StatefulWidget {
  const NCaffeeList({super.key});

  @override
  State<NCaffeeList> createState() => _NCaffeeListState();
}

class _NCaffeeListState extends State<NCaffeeList> {
  @override
  Widget build(BuildContext context) {
    final ncafee = Provider.of<List<PreferenceCoffee>?>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/home.jpg'),
        ),
      ),
      child: ListView.builder(
        itemCount: ncafee!.length,
        itemBuilder: (context, index) {
          return NCafeeList(ncafee: ncafee[index]);
        },
      ),
    );
  }
}
