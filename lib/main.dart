import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:want_coffee/firebase_options.dart';
import 'package:want_coffee/models/preference_coffee.dart';
import 'package:want_coffee/models/user.dart';
import 'package:want_coffee/screens/wrapper.dart';
import 'package:want_coffee/services/auth.dart';
import 'package:want_coffee/services/database.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    // return StreamProvider.value(
    //   value: AuthService().user,
    //   initialData: null,
    //   child: MaterialApp(
    //     home: Wrapper(),
    //   ),
    // );
    return MultiProvider(
      providers: [
        //stream of uauthentication user
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        //stream list of preference users coffee
        StreamProvider<List<PreferenceCoffee>?>.value(
          value: DatabaseService(user.toString()).ncaffeStream,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
