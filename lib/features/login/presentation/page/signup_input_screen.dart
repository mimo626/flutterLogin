import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/login/presentation/page/login_screen.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '사용하실 이메일, 닉네임\n비밀번호를 입력해 주세요',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility_off),
                  onPressed: () {
                    // 비밀번호 표시 기능 구현 가능
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.visibility_off),
                  onPressed: () {
                    // 비밀번호 확인 표시 기능 구현 가능
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, // 버튼의 넓이를 화면 전체로 설정
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    )
                ),
                onPressed: () {
                  // 다음 버튼 클릭 시 처리할 내용
                  //회원가입 로직
                  if(_passwordController.text == _confirmPasswordController.text){
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text)
                        .catchError((e) {
                      //회원가입 실패시
                      print(e);
                    }).then((value) {
                      // 회원가입 성공 시
                      User? user = FirebaseAuth.instance.currentUser;
                      user?.updateProfile(displayName: _nicknameController.text);

                      _emailController.clear();
                      _nicknameController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                      print('회원가입 성공');
                      FocusScope.of(context).unfocus();
                      context.go('/login');
                    });
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("비밀번호를 동일하게 입력해 주세요,"))
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('다음', style: TextStyle(color: Colors.white)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}