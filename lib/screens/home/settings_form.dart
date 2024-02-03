import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:want_coffee/constanst.dart';
import 'package:want_coffee/models/user.dart';
import 'package:want_coffee/services/database.dart';
import 'package:want_coffee/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Perbarui Data Pengguna',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: inpDecor.copyWith(hintText: null),
                    initialValue: userData?.name,
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: inpDecor.copyWith(hintText: null),
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('$sugar sendok gula'));
                    }).toList(),
                    onChanged: (val) => setState(() {
                      _currentSugars = val;
                    }),
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    activeColor:
                        Colors.brown[_currentStrength ?? userData!.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData!.strength],
                    min: 100,
                    max: 900,
                    divisions: 4,
                    value: (_currentStrength ?? userData?.strength)!.toDouble(),
                    onChanged: (val) => setState(
                      () {
                        _currentStrength = val.round();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(user?.uid).updateUserData(
                            _currentSugars ?? userData!.sugars,
                            _currentName ?? userData!.name,
                            _currentStrength ?? userData!.strength,
                          );
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.download, color: Colors.black),
                      label: const Text(
                        'Simpan',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
          ;
        });
  }
}
