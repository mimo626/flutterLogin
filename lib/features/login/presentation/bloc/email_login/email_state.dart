import 'package:equatable/equatable.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object?> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailSuccess extends EmailState {
  final String userName;
  final String email;

  EmailSuccess({required this.userName, required this.email});
}

class EmailFailure extends EmailState {
  final String message;

  const EmailFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
