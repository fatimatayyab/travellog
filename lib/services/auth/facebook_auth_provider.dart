// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:travellog3/services/auth/auth_provider.dart';
// import 'package:travellog3/services/auth/auth_user.dart';

// class FacebookAuthProvider implements AuthProvider {
//   @override
//   Future<AuthUser> createUser({
//     required String email,
//     required String password,
//   }) async {
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//     OAuthCredential(providerId: GoogleAuthProvider.PROVIDER_ID, signInMethod: GoogleAuthProvider.GOOGLE_SIGN_IN_METHOD)
    
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProviFder.credential(loginResult.accessToken!.token);

//     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//   }

//   @override
//   // TODO: implement currentUser
//   AuthUser? get currentUser => throw UnimplementedError();

//   @override
//   Future<void> initialize() {
//     // TODO: implement initialize
//     throw UnimplementedError();
//   }

//   @override
//   Future<AuthUser> logIn({required String email, required String password}) {
//     // TODO: implement logIn
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> logOut() {
//     // TODO: implement logOut
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> sendEmailVerification() {
//     // TODO: implement sendEmailVerification
//     throw UnimplementedError();
//   }
// }
