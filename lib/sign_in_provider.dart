import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignInProvider {
  const SignInProvider();
  void signIn(BuildContext context, GoogleSignInAuthentication authentication);
}
