import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Authentication Proccessing...',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 24.0,
                ),
                SpinKitChasingDots(
                  color: Colors.brown,
                  size: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
