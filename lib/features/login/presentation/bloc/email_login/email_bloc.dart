import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_event.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EmailBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(EmailInitial()) {
    on<EmailSignInRequested>(_onEmailSignInRequested);
  }

  Future<void> _onEmailSignInRequested(
      EmailSignInRequested event, Emitter<EmailState> emit) async {
    emit(EmailLoading());
    try {
      // 기본값 설정
      String userName = 'Unknown';
      String email = 'unknown@example.com';

      // Firebase 인증 호출
      UserCredential _credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Firestore에서 해당 사용자의 문서를 가져옵니다.
      DocumentSnapshot documentSnapshot = await _firestore
          .collection('users')
          .doc(_credential.user!.uid)
          .get();

      // 문서가 존재하는지 확인
      if (documentSnapshot.exists) {
        // 문서의 데이터를 가져옵니다.
        Map<String, dynamic>? userData =
        documentSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          userName = userData['nickname'] ?? 'Unknown';
          email = userData['email'] ?? 'unknown@example.com';
        }
      }

      emit(EmailSuccess(userName: userName, email: email)); // 로그인 성공
    } on FirebaseAuthException catch (e) {
      emit(EmailFailure(message: e.message ?? '로그인 실패')); // 실패 시 에러 메시지
    } catch (e) {
      emit(EmailFailure(message: '로그인 실패: 알 수 없는 오류가 발생했습니다.'));
    }
  }
}
