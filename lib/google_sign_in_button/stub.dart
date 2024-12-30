import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase_sign_in_provider.dart';

typedef OnSignIn = void Function(
    BuildContext context, GoogleSignInAuthentication authentication);

abstract class GoogleSignInButton {
  static void init({String? clientId}) {}

  static Widget firebase({
    required String clientId,
    OnSignInWithFirebase? onSignIn,
  }) =>
      Container();
}
