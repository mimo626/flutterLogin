import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/signup/domain/usecases/user_usecase.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_event.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserUsecase _userUsecase;

  SignupBloc({required UserUsecase userUsecase})
      : _userUsecase = userUsecase,
        super(SignupInitial(email: '',
          nickName: '',
          password: '',
          confirmPassword: '',
          isFormValid: false)) {
    on<OnChangedEmail>(_onChangedEmail);
    on<OnChangedNickName>(_onChangedNickName);
    on<OnChangedPassword>(_onChangedPassword);
    on<OnChangedConfirmPassword>(_onChangedConfirmPassword);
    on<EmailSignup>(_onEmailSignup);
  }

  // 이메일 변경 이벤트 처리
  void _onChangedEmail(OnChangedEmail event, Emitter<SignupState> emit) {
    if (state is SignupInitial) {
      final currentState = state as SignupInitial;
      emit(currentState.copyWith(email: event.email));
      _checkFormValidity(emit);
    }
  }

  // 닉네임 변경 이벤트 처리
  void _onChangedNickName(OnChangedNickName event, Emitter<SignupState> emit) {
    if (state is SignupInitial) {
      final currentState = state as SignupInitial;
      emit(currentState.copyWith(nickName: event.nickName));
      _checkFormValidity(emit);
    }
  }

  // 비밀번호 변경 이벤트 처리
  void _onChangedPassword(OnChangedPassword event, Emitter<SignupState> emit) {
    if (state is SignupInitial) {
      final currentState = state as SignupInitial;
      emit(currentState.copyWith(password: event.password));
      _checkFormValidity(emit);
    }
  }

  // 비밀번호 확인 변경 이벤트 처리
  void _onChangedConfirmPassword(OnChangedConfirmPassword event, Emitter<SignupState> emit) {
    if (state is SignupInitial) {
      final currentState = state as SignupInitial;
      emit(currentState.copyWith(confirmPassword: event.confirmPassword));
      _checkFormValidity(emit);
    }
  }

  // 폼의 유효성 검사를 수행하는 메서드
  void _checkFormValidity(Emitter<SignupState> emit) {
    if (state is SignupInitial) {
      final currentState = state as SignupInitial;
      final isPasswordValid = currentState.password == currentState.confirmPassword &&
          currentState.password.isNotEmpty;

      final isFormValid = currentState.email.isNotEmpty &&
          currentState.nickName.isNotEmpty &&
          isPasswordValid;

      emit(currentState.copyWith(
        isFormValid: isFormValid,
      ));
    }
  }

  // 회원가입 로직 처리
  Future<void> _onEmailSignup(
      EmailSignup event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      await _userUsecase.execute(event.email, event.password, event.nickName);
      emit(SignupSuccess());
    } catch (e) {
      emit(const SignupFailure(
          message: '회원가입 실패: 알 수 없는 오류가 발생했습니다.'));
      emit(SignupInitial(email: event.email,
          nickName: event.nickName,
          password: event.password,
          confirmPassword: event.confirmPassword,
          isFormValid: false)); // 에러 후에도 초기 상태로 전환
    }
  }
}
