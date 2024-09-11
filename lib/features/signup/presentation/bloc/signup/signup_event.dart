import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable{
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class EmailSignup extends SignupEvent {
  final String email;
  final String nickName;
  final String password;
  final String confirmPassword;

  const EmailSignup({required this.email, required this.nickName, required this.password, required this.confirmPassword});

  @override
  List<Object?> get props => [email, nickName, password, confirmPassword];

}

class OnChangedEmail extends SignupEvent {
  final String email;

  const OnChangedEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class OnChangedNickName extends SignupEvent {
  final String nickName;

  const OnChangedNickName(this.nickName);

  @override
  List<Object?> get props => [nickName];
}

class OnChangedPassword extends SignupEvent {
  final String password;

  const OnChangedPassword(this.password);

  @override
  List<Object?> get props => [password];
}

class OnChangedConfirmPassword extends SignupEvent {
  final String confirmPassword;

  const OnChangedConfirmPassword(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}
