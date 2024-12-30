import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'sign_in_provider.dart';

typedef OnSignInWithFirebase = void Function(
    BuildContext context, UserCredential credential);

class FirebaseSignInProvider implements SignInProvider {
  const FirebaseSignInProvider(
      {required this.onSignIn, FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  final FirebaseAuth? _firebaseAuth;
  final OnSignInWithFirebase? onSignIn;

  @override
  void signIn(
      BuildContext context, GoogleSignInAuthentication authentication) async {
    final oauthCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    final instance = _firebaseAuth ?? FirebaseAuth.instance;
    final userCredential = await instance.signInWithCredential(oauthCredential);
    if (context.mounted) {
      onSignIn?.call(context, userCredential);
    }
  }
}
