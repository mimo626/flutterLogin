import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/login/presentation/page/login_screen.dart';

class Onboarding1Screen extends StatefulWidget {
  @override
  _Onboarding1ScreenState createState() => _Onboarding1ScreenState();
}

class _Onboarding1ScreenState extends State<Onboarding1Screen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildOnboardingPage(
                imagePath: 'lib/assets/onboarding1.png', // 사용자가 업로드한 이미지 경로
                title: '나만의 화장품 라인으로\n깊이 있는 아름다움을\n창조해 보세요.',
                description: '코세틱과 함께 개인 브랜드를 구축하고,\n나만의 화장품을 만들 수 있습니다.',
              ),
              // 두 번째 페이지
              _buildOnboardingPage(
                imagePath: 'lib/assets/onboarding2.png',
                title: '당신만을 위한, 맞춤형\n추천 상품으로 완벽한\n선택을 제안합니다.',
                description: '코세틱과 함께 개인 브랜드를 구축하고,\n나만의 화장품을 만들 수 있습니다.',
              ),
              // 세 번째 페이지
              _buildOnboardingPage(
                imagePath: 'lib/assets/onboarding3.png',
                title: '나만의 레시피로,\n당신에게 맞는 화장품을\n 추천합니다.',
                description: '코세틱과 함께 개인 브랜드를 구축하고,\n나만의 화장품을 만들 수 있습니다.',
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Row(
              children: List.generate(3, (index) => buildDot(index, context)),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: _currentPage == 2
                ? FloatingActionButton(
              onPressed: () {
                // 온보딩 완료 후 다음 화면(로그인 등)으로 이동
                context.go('/login');
              },
              child: Icon(Icons.arrow_forward),
            )
                : SizedBox.shrink(),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: TextButton(
              onPressed: () {
                // 건너뛰기 버튼 동작 (로그인 화면으로 이동)
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text("건너뛰기", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({required String imagePath, required String title, required String description}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: _currentPage == index ? 20 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
