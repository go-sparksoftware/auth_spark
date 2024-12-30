import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../firebase_sign_in_provider.dart';
import '../sign_in_provider.dart';
import 'stub.dart';

class GoogleSignInButtonMobile extends StatefulWidget {
  const GoogleSignInButtonMobile({
    super.key,
    required this.clientId,
    OnSignIn? onSignIn,
  }) : _provider = onSignIn;

  GoogleSignInButtonMobile.firebase({
    super.key,
    required this.clientId,
    FirebaseAuth? firebaseAuth,
    OnSignInWithFirebase? onSignIn,
  }) : _provider = FirebaseSignInProvider(
            onSignIn: onSignIn, firebaseAuth: firebaseAuth);

  final String clientId;
  final dynamic _provider;

  @override
  State<GoogleSignInButtonMobile> createState() =>
      _GoogleSignInButtonMobileState();

  void signIn(
      BuildContext context, GoogleSignInAuthentication authentication) async {
    switch (_provider) {
      case OnSignIn onSignIn:
        onSignIn(context, authentication);
        break;
      case SignInProvider provider:
        provider.signIn(context, authentication);
        break;
    }
  }
}

class _GoogleSignInButtonMobileState extends State<GoogleSignInButtonMobile> {
  // late final StreamSubscription subscription;
  late final GoogleSignIn google =
      GoogleSignIn(serverClientId: widget.clientId);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      TextButton(onPressed: signIn, child: const Text("Sign in"));

  void signIn() async {
    final context = this.context;
    final account = await google.signIn();
    if (account case GoogleSignInAccount account) {
      final authentication = await account.authentication;

      Future.microtask(() {
        if (context.mounted) {
          widget.signIn(context, authentication);
        }
      });
    } else {
      debugPrint("No account returned from Google");
    }
  }
}
