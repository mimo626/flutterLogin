import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/login/domain/usecases/user_usecase.dart';
import 'package:login/features/login/presentation/bloc/signup/signup_event.dart';
import 'package:login/features/login/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserUsecase _userUsecase;

  SignupBloc({required UserUsecase userUsecase})
      : _userUsecase = userUsecase,
        super(SignupInitial()) {
    on<EmailSignup>(_onEmailSignup);
  }

  // 이벤트 처리 메서드
  Future<void> _onEmailSignup(
      EmailSignup event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      await _userUsecase.execute(event.email, event.password, event.nickName);
      print("Bloc------------------------");
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(message: e.message ?? '회원가입 실패'));
    } catch (e) {
      emit(const SignupFailure(
          message: '회원가입 실패: 알 수 없는 오류가 발생했습니다.'));
    }
  }
}
