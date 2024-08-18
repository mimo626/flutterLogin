import 'package:equatable/equatable.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object?> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailSuccess extends EmailState {}

class EmailFailure extends EmailState {
  final String message;

  const EmailFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
