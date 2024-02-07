import 'package:flutter/material.dart';
import 'package:travellog3/services/auth/auth_service.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final TextEditingController _email;
  @override
  void initState() {
    _email = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Enter your Email and we will send you a Password Reset Link',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _email,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
        ),
        const Text("Enter Your Email"),
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
            await AuthService.firebase().sendPasswordResetEmail(email: email, context: context);
            
          },
          child: const Text(
            "Reset Password",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ]),
    );
  }
}
