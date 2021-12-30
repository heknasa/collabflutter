import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider {
  static final googleSignInProvider = Provider<GoogleSignIn>((ref) {
    return GoogleSignIn();
  });

  static final authProvider = Provider<FirebaseAuth>((ref) {
    return FirebaseAuth.instance;
  });

  static final firestoreProvider = Provider<FirebaseFirestore>((ref) {
    return FirebaseFirestore.instance;
  });  

  static final cloudStorageProvider = Provider<FirebaseStorage>((ref) {
    return FirebaseStorage.instance;
  });
}