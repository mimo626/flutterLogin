import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/presentation/bloc/email_login/email_bloc.dart';
import 'features/login/presentation/bloc/email_login/email_state.dart';
import 'features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'features/login/presentation/bloc/google_login/auth_state.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('마이페이지'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 설정 버튼 클릭 시 실행될 코드
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  radius: 30,
                ),
                SizedBox(width: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    return BlocBuilder<EmailBloc, EmailState>(
                      builder: (context, emailState) {
                        // 초기 값 설정
                        String userName = 'Unknown';
                        String email = 'unknown@example.com';

                        // AuthBloc의 상태가 AuthAuthenticated일 때 값 변경
                        if (authState is AuthAuthenticated) {
                          userName = authState.userName;
                          email = authState.email;
                        }

                        // EmailBloc의 상태가 EmailSuccess일 때 값 변경
                        if (emailState is EmailSuccess) {
                          userName = emailState.userName;
                          email = emailState.email;
                        }

                        return Column(
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(email),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeatureItem(Icons.list_alt, '주문목록', () {
                  // 주문목록 클릭 시 실행될 코드
                }),
                _buildFeatureItem(Icons.rate_review, '리뷰관리', () {
                  // 리뷰관리 클릭 시 실행될 코드
                }),
                _buildFeatureItem(Icons.card_giftcard, '쿠폰 & 포인트', () {
                  // 쿠폰 & 포인트 클릭 시 실행될 코드
                }),
                _buildFeatureItem(Icons.grade, '내 등급', () {
                  // 내 등급 클릭 시 실행될 코드
                }),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: const Text("계정설정", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
          ),
          ListTile(
            title: Text('내 정보 관리'),
            onTap: () {
              // 내 정보 관리 클릭 시 실행될 코드
            },
          ),
          ListTile(
            title: Text('배송지 관리'),
            onTap: () {
              // 배송지 관리 클릭 시 실행될 코드
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: const Text("고객문의", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
          ),
          ListTile(
            title: Text('공지사항'),
            onTap: () {
              // 공지사항 클릭 시 실행될 코드
            },
          ),
          ListTile(
            title: Text('고객센터'),
            onTap: () {
              // 고객센터 클릭 시 실행될 코드
            },
          ),
          ListTile(
            title: Text('COSETIC Share'),
            onTap: () {
              // COSETIC Share 클릭 시 실행될 코드
            },
          ),
          ListTile(
            title: Text('About COSETIC'),
            onTap: () {
              // About COSETIC 클릭 시 실행될 코드
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 30, color: Colors.pink),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }


}