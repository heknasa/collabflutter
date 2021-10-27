import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/services/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends StateNotifier<User?> {
  final Reader _read;
  StreamSubscription<User?>? _authStateSubscription;

  AuthController(this._read) : super(null) {
    _authStateSubscription?.cancel();
    state = _read(AuthRepository.authRepositoryProvider).getCurrentUser;
    _authStateSubscription = _read(AuthRepository.authRepositoryProvider).authStateChanges.listen((event) {
      state = event;
    });
  }

  static final authControllerProvider = StateNotifierProvider((ref) {
    return AuthController(ref.read);
  });

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  void signInWithGoogle() {
    _read(AuthRepository.authRepositoryProvider).signInWithGoogle();
  }

  void signOut() {
    _read(AuthRepository.authRepositoryProvider).signOut();
  }
}