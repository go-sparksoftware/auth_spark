import 'package:app_spark/material_symbols.dart';
import 'package:flutter/material.dart';

import 'app_user.dart';

class UserCircleAvatar extends StatelessWidget {
  const UserCircleAvatar({super.key, this.user, this.radius});
  const UserCircleAvatar.large({super.key, this.user}) : radius = 40;

  final AppUser? user;
  final double? radius;

  @override
  Widget build(BuildContext context) => switch (user) {
        AuthenticatedUser user => CircleAvatar(
            radius: radius,
            foregroundImage:
                user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
            child: user.avatarUrl == null ? Text(user.initials) : null,
          ),
        _ => CircleAvatar(
            radius: radius, child: const Icon(MaterialSymbols.person))
      };
}
