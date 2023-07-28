import 'dart:developer';

import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as gCal;
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;

import '../repository/calendar/calendar_model.dart';
import '../repository/calendar/calendar_repository.dart';
import '../repository/profile/domain/profile_model.dart';
import '../repository/relation/relation_model.dart';
import '../repository/relation/relation_repository.dart';
import '../screen/settings/controllers/settings.dart';
import '../state/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final ProviderRef<AuthNotifier> ref;
  AuthNotifier(this.ref) : super(const AuthState.initializing()) {
    _firebaseAuth = FirebaseAuth.instance;
    init();
  }

  late FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '[YOUR_OAUTH_2_CLIENT_ID]',
    scopes: <String>[
      'email',
      'profile',
      'https://www.googleapis.com/auth/calendar'
    ],
  );

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<GoogleSignInAccount?> onCurrentUserChanged() =>
      _googleSignIn.onCurrentUserChanged;
  auth.AuthClient? _authClient;
  auth.AuthClient? get authClient => _authClient;
  GoogleSignInAccount? _googleSignInAccount;

  Future<void> init() async {
    final bool isFormLogin = ref.watch(Settings.isFireBaseLoginProvider);
    if (isFormLogin) {
      state = const AuthState.loading();
      _googleSignInAccount = await _googleSignIn.signInSilently();
      _authClient = await _googleSignIn.authenticatedClient();
      if (_authClient != null) {
        state = AuthState.ready(currentUser!);
      }
    }
  }

  //Google sign in
  Future<Profile?> signInWithGoogle() async {
    //begin interactive sign in process
    state = const AuthState.loading();

    _googleSignInAccount = await _googleSignIn.signIn();

    log('{$_googleSignInAccount.user}', name: 'Google User');

    // obtain with details from request
    final GoogleSignInAuthentication gAuth =
        await _googleSignInAccount!.authentication;

    _authClient = await _googleSignIn.authenticatedClient();

    //create a new credential for user
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    if (userCredential.user != null) {
      log('$userCredential', name: 'signInWithCredential');
      state = AuthState.ready(userCredential.user!);

      final CalendarRepository calendarRepository =
          ref.read(calendarRepositoryProvider);
      final Calendar? calendar =
          await calendarRepository.searchByEmail(userCredential.user!.email!);
      if (calendar != null) {
        log(calendar.toMap().toString(), name: 'calendar');

        final RelationsRepository relationRepository =
            ref.read(relationsRepositoryProvider);

        assert(authClient != null, 'Authenticated client missing!');

        final gCal.CalendarApi gCalAPI = gCal.CalendarApi(authClient!);
       final bool isExist =
            await relationRepository.isRelationExist(userCredential.user!.uid);
        if (!isExist) {
          final List<Relation> relationList =
              await relationRepository.fetchRelations(uid: calendar.hostId);
          bool isAccepted = false;
          for (Relation relation in relationList) {
            // try {
            //   final gCal.CalendarListEntry request =
            //       gCal.CalendarListEntry(id: relation.calenderId);
            //   await gCalAPI.calendarList.insert(request);
            //   log('${relation.name} Successfull', name: 'CalendarListInsert');
            //   isAccepted = true;
            // } catch (e) {
            //   log('${relation.name} $e', name: 'CalendarListInsert');
            // }

            await relationRepository.addRelation(
                uid: userCredential.user!.uid,
                name: relation.name,
                email: relation.email,
                calenderId: relation.calenderId,
                hostId: relation.hostId,
                isAccepted: isAccepted,
                display: 0,
                birthday: 0,
                role: 0,
                occupation: 0,
                userId: relation.uid);
          }
        }
      } else {
        log('No Family Setup Yet', name: 'calendar');
      }
      return Profile(
          id: userCredential.user!.uid,
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          pictureUrl: userCredential.user!.photoURL!,
          accessToken: gAuth.accessToken!,
          isNotNew: false,
          created: DateTime.now(),
          updated: DateTime.now());
    }

    state = const AuthState.error('Google Signin Error Occored!');
    return null;
    // finally, let's sign in
  }

  Future<void> signOut() async {
    state = const AuthState.initializing();
    await _firebaseAuth.signOut();
    await _googleSignIn.disconnect();
  }
}
