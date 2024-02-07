// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:travellog3/services/auth/auth_exceptions.dart';
import 'package:travellog3/services/auth/auth_service.dart';
import 'package:travellog3/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Text("Enter Your Email"),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                      ),
                      const Text("Enter Your Password"),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          color: const Color(0XFFffc444),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0XFFffc444),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;

                            try {
                              await AuthService.firebase().logIn(
                                email: email,
                                password: password,
                              );
                              final user = AuthService.firebase().currentUser;

                              if (user?.isEmailVerified ?? false) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/profileview/', (route) => false);
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/verifyemail/',
                                  (route) => false,
                                );
                              }
                            } on UserNotFoundAuthException {
                              await showErrorDialog(
                                context,
                                'User Not Found',
                              );
                            } on WrongPasswordAuthException {
                              await showErrorDialog(
                                context,
                                'Wrong Credentials',
                              );
                            } on GenericAuthException {
                              await showErrorDialog(
                                context,
                                'Authentication Error',
                              );
                            }
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/forgetpassword/');
                          },
                          child: const Text('Forgot Password'),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/register/',
                                    (route) => false,
                                  );
                                },
                                child: const Text('Signup here!'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('OR'),
                  SizedBox(
                    height: 50,
                    child: SignInButton(Buttons.google,
                        text: "Login With Google", onPressed: () async {
                      GoogleAuthProvider _googleAuthProvider =
                          GoogleAuthProvider();
                      await FirebaseAuth.instance
                          .signInWithProvider(_googleAuthProvider);

                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        if (user.emailVerified) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/profileview/', (route) => false);
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/verifyemail/',
                            (route) => false,
                          );
                        }
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/registerview/',
                          (route) => false,
                        );
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: SignInButton(Buttons.facebook,
                        text: "Login With Facebook", onPressed: () async {
                      final LoginResult loginResult =
                          await FacebookAuth.instance.login();
                      final OAuthCredential facebookAuthCredential =
                          FacebookAuthProvider.credential(
                              loginResult.accessToken!.token);
                      await FirebaseAuth.instance
                          .signInWithCredential(facebookAuthCredential);
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        if (user.emailVerified) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/profileview/', (route) => false);
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/verifyemail/',
                            (route) => false,
                          );
                        }
                      } else {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/registerview/',
                          (route) => false,
                        );
                      }
                    }),
                  ),
                  // OutlinedButton.icon(
                  //   onPressed: () {},
                  //   icon: const Image(
                  //     image: AssetImage('assets/images/googleIcon.png'),
                  //     width: 20.0,
                  //   ),
                  //   label: const Text("   Login With Google   "),
                  // ),
                  // OutlinedButton.icon(
                  //   onPressed: () {},
                  //   icon: const Image(
                  //     image: AssetImage('assets/images/facebookIcon.png'),
                  //     width: 30.0,
                  //   ),
                  //   label: const Text("Login With Facebook"),
                  // )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
