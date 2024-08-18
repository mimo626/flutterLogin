import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_event.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final FirebaseAuth _firebaseAuth;

  EmailBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(EmailInitial()) {
    on<EmailSignInRequested>(_onEmailSignInRequested);
  }

  Future<void> _onEmailSignInRequested(
      EmailSignInRequested event, Emitter<EmailState> emit) async {
    emit(EmailLoading());
    try {
      // Firebase 인증 호출
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(EmailSuccess()); // 로그인 성공
    } on FirebaseAuthException catch (e) {
      emit(EmailFailure(message: e.message ?? '로그인 실패')); // 실패 시 에러 메시지
    } catch (e) {
      emit(EmailFailure(message: '로그인 실패: 알 수 없는 오류가 발생했습니다.'));
    }
  }
}
