import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_bloc.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_state.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSnackBarShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) => current is AuthAuthenticated,
            listener: (context, state) {
              if (state is AuthAuthenticated && !_isSnackBarShown) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${state.userName}님 로그인되었습니다.')),
                );
                print(_isSnackBarShown);
                _isSnackBarShown = true;
                print(_isSnackBarShown);
              }
            },
          ),
          BlocListener<EmailBloc, EmailState>(
            listenWhen: (previous, current) => current is EmailSuccess,
            listener: (context, state) {
              if (state is EmailSuccess && !_isSnackBarShown) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('이메일로 로그인되었습니다.')),
                );
                _isSnackBarShown = true;
              }
            },
          ),
        ],
        child: Center(
          child: Text("home"),
        ),
      ),
    );
  }
}
