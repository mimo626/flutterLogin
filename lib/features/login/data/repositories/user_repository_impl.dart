import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/features/login/domain/repositories/user_repository.dart';
import 'package:login/features/login/domain/model/user.dart';


class UserRepositoryImpl implements UserRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<void> signUp(User user) async {
    try {
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      print("UserRepositoryImpl1------------------------");
      print("${user.email}, ${user.nickname}");

      await _firestore.collection('users').doc(credentials.user!.uid).set({
        'email': user.email,
        'password': user.password,
        'nickname': user.nickname,
      });
      print("UserRepositoryImpl2------------------------");
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
