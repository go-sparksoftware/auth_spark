import 'package:firebase_auth/firebase_auth.dart';

import 'firebase/user_extension.dart';

sealed class AppUser {
  const AppUser();

  factory AppUser.anonymous() => const AnonymousUser();
  factory AppUser.authenticated(FirebaseAuth auth, User user,
          {String? avatarUrl}) =>
      AuthenticatedUser(auth, user,
          initials: user.initials,
          displayName: user.displayName,
          avatarUrl: avatarUrl);
  factory AppUser.registered(FirebaseAuth auth, User user,
          {required String initials,
          required String displayName,
          String? avatarUrl}) =>
      AuthenticatedUser(auth, user,
          initials: initials, displayName: displayName, avatarUrl: avatarUrl);
}

class AnonymousUser implements AppUser {
  const AnonymousUser();
}

class AuthenticatedUser implements AppUser {
  const AuthenticatedUser(this.auth, this.user,
      {required this.initials, String? displayName, required this.avatarUrl})
      : _displayName = displayName;
  final FirebaseAuth auth;
  final User user;
  final String initials;
  final String? _displayName;
  final String? avatarUrl;

  String get displayName {
    assert(_displayName != null || user.displayName != null);
    return (_displayName ?? user.displayName)!;
  }

  String get email {
    assert(user.email != null);
    return user.email!;
  }
}
