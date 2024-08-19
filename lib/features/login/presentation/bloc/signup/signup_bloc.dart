import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/login/presentation/bloc/signup/signup_event.dart';
import 'package:login/features/login/presentation/bloc/signup/signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  final FirebaseAuth _firebaseAuth;

  SignupBloc({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      super(SignupInitial()) {
    on<EmailSignup>(_onEmailSignup);
  }

  Future<void> _onEmailSignup(
      EmailSignup event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
      );
      User? user = _firebaseAuth.currentUser;
      user?.updateDisplayName(event.nickName);
      print('닉네임: ${event.nickName}');
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailure(message: e.message ?? '회원가입 실패'));
    } catch(e) {
      emit(SignupFailure(message: '회원가입 실패: 알 수 없는 오류가 발생했습니다.'));
    }
  }
}