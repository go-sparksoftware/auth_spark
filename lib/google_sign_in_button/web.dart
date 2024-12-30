import 'package:flutter/material.dart';

import '../firebase_sign_in_provider.dart';
import 'google_sign_in_button_web.dart';

abstract class GoogleSignInButton {
  static void init({String? clientId}) {}

  static Widget firebase({
    required String clientId,
    OnSignInWithFirebase? onSignIn,
  }) =>
      GoogleSignInButtonWeb.firebase(
        clientId: clientId,
        onSignIn: onSignIn,
      );
}
