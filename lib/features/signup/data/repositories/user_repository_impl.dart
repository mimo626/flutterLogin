import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/features/signup/data/datasources/user_datasource.dart';
import 'package:login/features/signup/data/mapper/signup_user_mapper.dart';
import 'package:login/features/signup/data/model/signup_user_model.dart'; // 파일명 오타 수정
import 'package:login/features/signup/domain/entity/signup_user.dart';
import 'package:login/features/signup/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<void> signUp(SignupUser user) async {
    try {
      // UserDatasource 인스턴스 생성
      final userDatasource = UserDatasource(_firebaseAuth, _firestore);

      // 도메인 엔티티 -> 데이터 모델로 변환
      SignupUserModel signupUserModel = SignupUserMapper.entityToModel(user);

      // UserDatasource의 signUp 메서드 호출
      await userDatasource.signUp(signupUserModel);
    } catch (e) {
      print('Error during signup: $e');
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }
}
