import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/providers/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  User? get getCurrentUser;
  Future<void> signInWithGoogle();  
  Future<void> signOut();
}

class AuthRepository implements BaseAuthRepository {
  final Reader _read;
  AuthRepository(this._read);

  static final authRepositoryProvider = Provider<AuthRepository>((ref) {
    return AuthRepository(ref.read);
  });

  @override
  Stream<User?> get authStateChanges => _read(FirebaseProvider.authProvider).authStateChanges();

  @override
  User? get getCurrentUser => _read(FirebaseProvider.authProvider).currentUser;

  @override
  Future<void> signInWithGoogle() async {
    await _read(FirebaseProvider.authProvider).signInWithPopup(GoogleAuthProvider());
  }

  @override
  Future<void> signOut() async {
    _read(FirebaseProvider.authProvider).signOut();
    _read(FirebaseProvider.googleSignInProvider).signOut();
  }
}