import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class TeamCAuthUser {
  TeamCAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<TeamCAuthUser> teamCAuthUserSubject =
    BehaviorSubject.seeded(TeamCAuthUser(loggedIn: false));
Stream<TeamCAuthUser> teamCAuthUserStream() =>
    teamCAuthUserSubject.asBroadcastStream().map((user) => currentUser = user);
