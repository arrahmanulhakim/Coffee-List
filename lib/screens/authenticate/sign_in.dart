import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:want_coffee/constanst.dart';
import 'package:want_coffee/services/auth.dart';
import 'package:want_coffee/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
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
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/sign-in-up.jpg'),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/sign-in.png'),
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
                        icon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Masuk',
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
                            dynamic result =
                                await _auth.signInWithEmailAndPassword(
                                    email = email, password = password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those credential';
                                loading = false;
                              });
                            } else {}
                            print('valid');
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: TextSpan(
                        text: 'Belum punya akun?  ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Daftar',
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
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
  }
}

/*
 Container(
                  width: deviseWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      dynamic result = await _auth.signInAnom();

                      if (result != null) {
                        print('Sign in' + result.uid);
                        print(result);
                      } else {
                        print('Not sign in');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.brown[200],
                      ),
                    ),
                    child: const Text('Login as anonymous'),
                  ),
                ),

*/

/*
  SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  label: const Text('Masuk',
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.brown[500],
                    ),
                  ),
                ),
              ),
*/
