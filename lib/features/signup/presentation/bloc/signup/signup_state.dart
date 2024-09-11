import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {
  final String email;
  final String nickName;
  final String password;
  final String confirmPassword;
  final bool isFormValid;

  SignupInitial({
    required this.email,
    required this.nickName,
    required this.password,
    required this.confirmPassword,
    required this.isFormValid,
  });

  SignupInitial copyWith({
    String? email,
    String? nickName,
    String? password,
    String? confirmPassword,
    bool? isFormValid,
  }) {
    return SignupInitial(
      email: email ?? this.email,
      nickName: nickName ?? this.nickName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  @override
  List<Object?> get props => [email, nickName, password, confirmPassword, isFormValid];
}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String message;

  const SignupFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
