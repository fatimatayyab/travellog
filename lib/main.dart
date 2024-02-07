import 'package:flutter/material.dart';
import 'package:travellog3/services/auth/auth_service.dart';
import 'package:travellog3/views/forget_password_view.dart';
import 'package:travellog3/views/login_view.dart';
import 'package:travellog3/views/profile_view.dart';
import 'package:travellog3/views/register_view.dart';
import 'package:travellog3/views/verify_email_view.dart';
import 'package:travellog3/views/welcome_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/verifyemail/': (context) => const VerifyEmailView(),
      '/profileview/': (context) => const ProfileView(),
      '/welcomeview/': (context) => const WelcomeView(),
      '/forgetpassword/' : (context) => const ForgetPassword(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const ProfileView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const WelcomeView();
            }
          default:
            return const Text('Loading');
        }
      },
    );
  }
}
