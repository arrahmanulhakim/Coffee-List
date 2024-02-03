import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:want_coffee/constanst.dart';
import 'package:want_coffee/services/auth.dart';
import 'package:want_coffee/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('Coffee List'),
              centerTitle: true,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/sign-in-up.jpg'),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      width: 200,
                      padding: const EdgeInsets.all(8),
                      child: Image.asset('assets/images/sign-up.png'),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: inpDecor,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      decoration: inpDecor.copyWith(hintText: 'Password'),
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.email, color: Colors.white),
                        label: const Text(
                          'Daftar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.brown[500],
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'please supply a valid email';
                              });
                            } else {}
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: TextSpan(
                        text: 'Sudah punya akun?  ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Masuk',
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                widget.toggleView();
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    ;
  }
}
