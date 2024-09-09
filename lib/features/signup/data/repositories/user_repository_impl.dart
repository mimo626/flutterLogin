import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/features/signup/domain/entity/signup_user.dart';
import 'package:login/features/signup/domain/repositories/user_repository.dart';


class UserRepositoryImpl implements UserRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<void> signUp(SignupUser user) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!!,
      );

      await _firestore.collection('users').doc(credentials.user!.uid).set({
        'email': user.email,
        'password': user.password,
        'nickname': user.nickname,
      });
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
