import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/custom_screen.dart';
import 'package:login/favorite_screen.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_bloc.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_state.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';
import 'package:login/home_screen.dart';
import 'package:login/my_screen.dart';
import 'package:login/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;
  final List<Widget> _screen = [
    HomeScreen(),
    StoreScreen(),
    CustomScreen(),
    FavoriteScreen(),
    MyScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:_screen[_currentIndex],
      bottomNavigationBar:
      BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed, // 애니메이션 제거
          selectedItemColor: Colors.pinkAccent, // 선택된 항목의 텍스트 색상
          unselectedItemColor: Colors.black38, // 선택되지 않은 항목의 텍스트 색상
          selectedLabelStyle: TextStyle(
            color: Colors.black, // 선택된 항목의 텍스트 스타일
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.black12, // 선택되지 않은 항목의 텍스트 스타일
          ),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black38,),
                label: '홈'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black38,),
                label: '스토어'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black38,),
                label: '맞춤'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black38,),
                label: '찜'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black38,),
                label: '마이페이지'
            ),
          ]),
    );
  }
}
