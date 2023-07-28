import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/auth_notifier.dart';
import 'state/auth_state.dart';

final Provider<AuthNotifier> authServiceProvider = Provider<AuthNotifier>(
    (ProviderRef<AuthNotifier> ref) => AuthNotifier(ref));

final StateNotifierProvider<AuthNotifier, AuthState> authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
        (StateNotifierProviderRef<AuthNotifier, AuthState> ref) {
  final AuthNotifier authService = ref.watch(authServiceProvider);
  return authService;
});

final StreamProvider<User?> authStateChangesProvider = StreamProvider<User?>(
    (StreamProviderRef<User?> ref) =>
        ref.watch(authServiceProvider).authStateChanges());
