import 'package:app_spark/material_symbols.dart';
import 'package:flutter/material.dart';

import 'app_user.dart';
import 'user_circle_avatar.dart';

typedef OnUserSettings = void Function(AuthenticatedUser user);

class AuthenticatedUserDialog extends StatelessWidget {
  const AuthenticatedUserDialog(this.user,
      {super.key,
      this.actions = const [],
      this.showSignOut = true,
      this.onUserSettings,
      this.initialsOnly = false});

  final AuthenticatedUser user;
  final List<Widget> actions;
  final bool showSignOut;
  final bool initialsOnly;
  final OnUserSettings? onUserSettings;

  @override
  Widget build(BuildContext context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.topRight,
          title: Center(child: Text(user.email)),
          titleTextStyle: Theme.of(context).textTheme.bodySmall,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserCircleAvatar.large(
                user: user,
                initialsOnly: initialsOnly,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Hello, ${user.displayName}",
                    style: Theme.of(context).textTheme.bodyLarge),
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ...actions,
            if (onUserSettings != null)
              IconButton(
                  onPressed: () {
                    onUserSettings!(user);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(MaterialSymbols.settings)),
            if (showSignOut)
              FilledButton.icon(
                  onPressed: () {
                    user.auth.signOut();
                    Navigator.of(context).pop();
                  },
                  label: const Text("Sign out"),
                  icon: const Icon(MaterialSymbols.logout))
          ]);
}
