import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/signup/domain/usecases/user_usecase.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_event.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserUsecase _userUsecase;

  SignupBloc({required UserUsecase userUsecase})
      : _userUsecase = userUsecase,
        super(SignupInitial()) {
    on<OnChangedEmail>(_onChangedEmail);
    on<OnChangedNickName>(_onChangedNickName);
    on<OnChangedPassword>(_onChangedPassword);
    on<OnChangedConfirmPassword>(_onChangedConfirmPassword);
    on<EmailSignup>(_onEmailSignup);
  }

  // 이벤트 처리 메서드
  void _onChangedEmail(OnChangedEmail event, Emitter<SignupState> emit) {
    final currentState = state as SignupInitial;
    emit(currentState.copyWith(email: event.email));
    _checkFormValidity(emit);
  }

  void _onChangedNickName(OnChangedNickName event, Emitter<SignupState> emit) {
    final currentState = state as SignupInitial;
    emit(currentState.copyWith(nickName: event.nickName));
    _checkFormValidity(emit);
  }

  void _onChangedPassword(OnChangedPassword event, Emitter<SignupState> emit) {
    final currentState = state as SignupInitial;
    emit(currentState.copyWith(password: event.password));
    _checkFormValidity(emit);
  }

  void _onChangedConfirmPassword(OnChangedConfirmPassword event, Emitter<SignupState> emit) {
    final currentState = state as SignupInitial;
    emit(currentState.copyWith(confirmPassword: event.confirmPassword));
    _checkFormValidity(emit);
  }

  void _checkFormValidity(Emitter<SignupState> emit) {
    final currentState = state as SignupInitial;
    final isFormValid = currentState.email.isNotEmpty &&
        currentState.nickName.isNotEmpty &&
        currentState.password.isNotEmpty &&
        currentState.confirmPassword.isNotEmpty &&
        currentState.password == currentState.confirmPassword;

    emit(currentState.copyWith(isFormValid: isFormValid));
  }

  Future<void> _onEmailSignup(
      EmailSignup event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      await _userUsecase.execute(event.email, event.password, event.nickName);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(message: e.message ?? '회원가입 실패'));
    } catch (e) {
      emit(const SignupFailure(
          message: '회원가입 실패: 알 수 없는 오류가 발생했습니다.'));
    }
  }
}
