import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/features/signup/data/model/signup_user_model.dart';

class UserDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserDatasource(this._firebaseAuth, this._firestore);

  Future<void> signUp(SignupUserModel user) async {
    try {
      // 회원 가입
      final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );
      // firestore에 데이터 저장
      await _firestore.collection('users').doc(credentials.user!.uid).set(user.toMap());

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          print('This email is already in use.');
          throw Exception('This email is already in use.');
        case "invalid-email":
          print('The email address is not valid.');
          throw Exception('The email address is not valid.');
        case "weak-password":
          print('The password is too weak.');
          throw Exception('The password is too weak.');
        case "operation-not-allowed":
          print('Email/password accounts are not enabled.');
          throw Exception('Email/password accounts are not enabled.');
        default:
          print('An unknown error occurred.');
          throw Exception('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      print('Failed to sign up: $e');
      throw Exception('Failed to sign up: $e');
    }
  }

}