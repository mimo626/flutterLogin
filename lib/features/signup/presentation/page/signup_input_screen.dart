import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_bloc.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_event.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_state.dart';

class SignupInputScreen extends StatefulWidget {
  const SignupInputScreen({super.key});

  @override
  State<SignupInputScreen> createState() => _SignupInputScreenState();
}

class _SignupInputScreenState extends State<SignupInputScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if(state is SignupSuccess) {
            _emailController.clear();
            _nicknameController.clear();
            _passwordController.clear();
            _confirmPasswordController.clear();
            print('회원가입 성공');
            FocusScope.of(context).unfocus();
            context.go('/login');
          }
          else if (state is SignupFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '사용하실 이메일, 닉네임\n비밀번호를 입력해 주세요',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: '이메일',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (email) {
                        context.read<SignupBloc>().add(OnChangedEmail(email));
                      },
                    );
                  }
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        labelText: '닉네임',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (nickName) {
                        context.read<SignupBloc>().add(OnChangedNickName(nickName));
                      },
                    );
                  }
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: '비밀번호',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (password) {
                        context.read<SignupBloc>().add(OnChangedPassword(password));
                      },
                    );
                  }
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: '비밀번호 확인',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (password) {
                        context.read<SignupBloc>().add(OnChangedConfirmPassword(password));
                      },
                    );
                  }
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, // 버튼의 넓이를 화면 전체로 설정
                child:
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    print("isFormValid: ${state}");
                    bool isButtonEnabled = state is SignupInitial && state.isFormValid;
                    print("isButtonEnabled: ${isButtonEnabled}");
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: isButtonEnabled
                          ? () {
                        context.read<SignupBloc>().add(
                          EmailSignup(
                            email: state.email,
                            nickName: state.nickName,
                            password: state.password,
                            confirmPassword: state.confirmPassword,
                          ),
                        );
                        print("다음버튼`````````````````````````````````````");

                      }
                          : null,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          '다음',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}