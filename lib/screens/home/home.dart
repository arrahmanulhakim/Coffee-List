import 'package:flutter/material.dart';
import 'package:want_coffee/screens/home/ncaffee_list.dart';
import 'package:want_coffee/screens/home/settings_form.dart';
import 'package:want_coffee/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          backgroundColor: Colors.grey[400],
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Coffee List'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 40,
            ),
          )
        ],
      ),
      body: const NCaffeeList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        onPressed: () {
          showSettingsPanel();
        },
        child: const Icon(
          Icons.coffee_maker_outlined,
          size: 48,
        ),
      ),
    );
  }
}
