// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travellog3/services/auth/auth_exceptions.dart';
import 'package:travellog3/services/auth/auth_service.dart';

import 'package:travellog3/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Sign Up to Start Creating Your Memories',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFFffc444),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 60,
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
                  TextField(
                    controller: _confirmPassword,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const Text("Confirm Your Password"),
                ],
              ),
              const SizedBox(
                height: 0,
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
                        if (_password.text == _confirmPassword.text) {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            await AuthService.firebase()
                                .createUser(email: email, password: password);

                            await AuthService.firebase()
                                .sendEmailVerification();
                            Navigator.of(context).pushNamed('/verifyemail/');
                          } on WeakPasswordAuthException {
                            showErrorDialog(context, 'Weak Password');
                          } on EmailAlreadyInUseAuthException {
                            showErrorDialog(context, 'Email Already In Use');
                          } on InvalidEmailAuthException {
                            showErrorDialog(context, 'Invalid Email Entered');
                          } on GenericAuthException {
                            await showErrorDialog(
                              context,
                              'Failed To Register ',
                            );
                          }
                        } else {
                          showErrorDialog(context, 'Passwords Do Not Match');
                        }
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () async {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/login/',
                                (route) => false,
                              );
                            },
                            child: const Text('Login here!'))
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('OR'),
                  SizedBox(
                    height: 50,
                    child: SignInButton(Buttons.google,
                        text: "SignUp With Google", onPressed: () async {
                      GoogleAuthProvider _googleAuthProvider =
                          GoogleAuthProvider();
                      await FirebaseAuth.instance
                          .signInWithProvider(_googleAuthProvider);
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        if (user.emailVerified) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/profile/',
                            (route) => false,
                          );
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/verifyemail/',
                            (route) => false,
                          );
                        }
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: SignInButton(Buttons.facebook,
                        text: "SignUp With Facebook", onPressed: () async {
                      final LoginResult loginResult =
                          await FacebookAuth.instance.login();
                      final OAuthCredential facebookAuthCredential =
                          FacebookAuthProvider.credential(
                              loginResult.accessToken!.token);

                      await FirebaseAuth.instance
                          .signInWithCredential(facebookAuthCredential);
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                      if (user != null) {
                        if (user.emailVerified) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/profile/',
                            (route) => false,
                          );
                        } else {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/verifyemail/',
                            (route) => false,
                          );
                        }
                      }
                    }),
                  ),
                  // OutlinedButton. icon(
                  //   onPressed: () {},
                  //   icon: const Image(
                  //     image: AssetImage('assets/images/googleIcon.png'),
                  //     width: 20.0,
                  //   ),
                  //   label: const Text("SignUp With Google"),
                  // ),
                  // OutlinedButton.icon(
                  //   onPressed: () {},
                  //   icon: const Image(
                  //     image:
                  //         AssetImage('assets/images/facebookIcon.png'),
                  //     width: 20.0,
                  //   ),
                  //   label: const Text("SignUp With Facebook"),
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
