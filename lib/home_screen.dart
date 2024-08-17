import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSnackBarShown = false; // 스낵바 표시 여부를 추적하는 변수

  @override
  void initState() {
    super.initState();

    // 초기 상태 확인
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated && !_isSnackBarShown) {
      //초기 화면 빌드가 완료된 뒤에 스낵바 표시
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${authState.userName}님 로그인되었습니다.')),
        );
        _isSnackBarShown = true; // 스낵바가 표시된 것으로 설정
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
          child: Text("home"),
        ),
    );
  }
}
