// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:travellog3/firebase_options.dart';
// import 'package:travellog3/services/auth/auth_exceptions.dart';
// import 'package:travellog3/services/auth/auth_provider.dart';
// import 'package:travellog3/services/auth/auth_user.dart';

// class GoogleAuthProvider implements AuthProvider {
//   @override
//   Future<AuthUser> createUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
      
//       await GoogleAuthProvider().createUser(email: email,
//        password: password,);
      
//   }

//       }


//   @override
 
//   AuthUser? get currentUser {
//     final user=GoogleAuthProvider().currentUser;
//     if (user != null) {
//       return AuthUser.fromFirebase(user);
//     } else {
//       return null;
//     }
//   }

//   @override
//   Future<void> initialize()  async{
//      await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }

//   @override
//   Future<AuthUser> logIn({required String email, required String password}) {
//    await GoogleAuthProvider().logIn(email: email, password: password);
//   }

//   @override
//   Future<void> logOut()async {
//     final user=GoogleAuthProvider().currentUser;
//     if (user != null) {
//       await GoogleAuthProvider().logOut();
//     } else {
//       throw UserNotLoggedInAuthException();
//     }
//   }

//   @override
//   Future<void> sendEmailVerification() {
    
//   }
// }
