import 'package:flutter/material.dart';
import 'package:travellog3/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail({required String email,required BuildContext context});
}
