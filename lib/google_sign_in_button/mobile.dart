import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';

import '../firebase_sign_in_provider.dart';
import 'google_sign_in_button_mobile.dart';

abstract class GoogleSignInButton {
  static void init({String? clientId}) {
    GoogleSignInPlatform.instance.init(clientId: clientId);
  }

  static Widget firebase({
    required String clientId,
    OnSignInWithFirebase? onSignIn,
  }) =>
      GoogleSignInButtonMobile.firebase(
        clientId: clientId,
        onSignIn: onSignIn,
      );
}
