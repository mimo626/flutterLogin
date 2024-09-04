abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userName;
  final String email;

  AuthAuthenticated({required this.email, required this.userName});
}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
