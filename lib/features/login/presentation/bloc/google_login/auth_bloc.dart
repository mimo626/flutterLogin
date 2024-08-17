import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_event.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        GoogleSignInAccount? _account = await _googleSignIn.signIn();
        if (_account != null) {
          GoogleSignInAuthentication _authentication = await _account.authentication;
          OAuthCredential _googleCredential = GoogleAuthProvider.credential(
            idToken: _authentication.idToken,
            accessToken: _authentication.accessToken,
          );

          UserCredential _credential = await _firebaseAuth.signInWithCredential(_googleCredential);

          if (_credential.user != null) {
            emit(AuthAuthenticated(userName: _credential.user!.displayName ?? ''));
          } else {
            emit(AuthError(message: '로그인 실패: 사용자 정보가 없습니다.'));
          }
        } else {
          emit(AuthError(message: '로그인 실패: Google Sign-In 취소됨.'));
        }
      } catch (e) {
        emit(AuthError(message: '로그인 중 오류 발생: ${e.toString()}'));
      }
    });
  }
}
