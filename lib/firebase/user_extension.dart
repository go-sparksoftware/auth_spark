import 'package:auth_spark/initials.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension UserExtension on User {
  String get initials => getInitials([if (displayName != null) displayName!]);
}
