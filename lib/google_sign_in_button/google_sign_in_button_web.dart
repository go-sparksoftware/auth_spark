import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: depend_on_referenced_packages
import 'package:google_sign_in_web/web_only.dart' as web;

import '../firebase_sign_in_provider.dart';
import '../sign_in_provider.dart';
import 'stub.dart';

class GoogleSignInButtonWeb extends StatefulWidget {
  const GoogleSignInButtonWeb({
    super.key,
    required this.clientId,
    OnSignIn? onSignIn,
  }) : _provider = onSignIn;

  GoogleSignInButtonWeb.firebase({
    super.key,
    required this.clientId,
    FirebaseAuth? firebaseAuth,
    OnSignInWithFirebase? onSignIn,
  }) : _provider = FirebaseSignInProvider(
            onSignIn: onSignIn, firebaseAuth: firebaseAuth);

  final String clientId;
  final dynamic _provider;

  @override
  State<GoogleSignInButtonWeb> createState() => _GoogleSignInButtonWebState();

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

class _GoogleSignInButtonWebState extends State<GoogleSignInButtonWeb> {
  late final StreamSubscription subscription;
  late final GoogleSignIn google = GoogleSignIn(clientId: widget.clientId);

  @override
  void initState() {
    super.initState();

    subscription = google.onCurrentUserChanged.listen((account) async {
      final context = this.context;
      if (account case GoogleSignInAccount account) {
        final authentication = await account.authentication;

        Future.microtask(() {
          if (context.mounted) {
            widget.signIn(context, authentication);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) => web.renderButton();
}
