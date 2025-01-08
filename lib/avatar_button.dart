import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'app_user.dart';
import 'authenticated_user_dialog.dart';
import 'firebase/user_extension.dart';
import 'user_circle_avatar.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({
    super.key,
    required this.stream,
    this.useDefaultUserDialog = false,
    this.onAuthenticatedDialog,
    this.onAuthenticatedPressed,
    this.onUserSettings,
    this.onAnonymousPressed,
    this.dialogActions = const [],
    this.initialsOnly = false,
  });
  AvatarButton.firebase({
    super.key,
    this.useDefaultUserDialog = false,
    this.onAuthenticatedDialog,
    this.onAuthenticatedPressed,
    this.onUserSettings,
    this.onAnonymousPressed,
    this.dialogActions = const [],
    this.initialsOnly = false,
    FirebaseAuth? instance,
    FutureOr<AuthenticatedUser> Function(AuthenticatedUser user) lookup = same,
  }) : stream = authInstance(instance)
            .authStateChanges()
            .asyncMap((user) async => switch (user) {
                  User user => await lookup(AuthenticatedUser(
                      authInstance(instance), user,
                      initials: user.initials, avatarUrl: user.photoURL)),
                  _ => const AnonymousUser()
                });
  final Stream<AppUser> stream;
  final void Function()? onAnonymousPressed;
  final void Function(AuthenticatedUser user)? onAuthenticatedPressed;
  final OnUserSettings? onUserSettings;
  final bool useDefaultUserDialog;
  final Widget Function(AuthenticatedUser user)? onAuthenticatedDialog;
  final List<Widget> dialogActions;
  final bool initialsOnly;

  bool get canAuthenticatePress =>
      useDefaultUserDialog ||
      onAuthenticatedPressed != null ||
      onAuthenticatedDialog != null;

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: stream,
      builder: (context, snapshot) => switch (snapshot.data) {
            AuthenticatedUser user => IconButton(
                onPressed:
                    canAuthenticatePress ? () => handle(context, user) : null,
                icon: UserCircleAvatar(
                  user: user,
                  initialsOnly: initialsOnly,
                ),
              ),
            _ => IconButton(
                onPressed: onAnonymousPressed,
                icon: const UserCircleAvatar(),
              )
          });

  void handle(BuildContext context, AuthenticatedUser user) async {
    if (onAuthenticatedDialog != null) {
      await showDialog(
          context: context, builder: (context) => onAuthenticatedDialog!(user));
    } else if (useDefaultUserDialog) {
      await showDialog(
          context: context,
          builder: (context) => AuthenticatedUserDialog(
                onUserSettings: onUserSettings,
                initialsOnly: initialsOnly,
                user,
                actions: dialogActions,
              ));
    } else if (onAuthenticatedPressed != null) {
      onAuthenticatedPressed!(user);
    }
  }

  static FirebaseAuth authInstance(FirebaseAuth? instance) =>
      instance ?? FirebaseAuth.instance;
  static AuthenticatedUser same(AuthenticatedUser user) => user;
}
