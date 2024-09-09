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

  const EmailSignup({required this.email, required this.nickName, required this.password});

  @override
  List<Object?> get props => [email, nickName, password];
}