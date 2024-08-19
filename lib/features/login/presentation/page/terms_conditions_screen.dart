import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:login/main.dart';

class TermsConditionsScreen extends StatefulWidget {
  @override
  _TermsConditionsScreenState createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  bool isAllChecked = false;
  bool isFirstChecked = false;
  bool isSecondChecked = false;
  bool isThirdChecked = false;
  bool isFourthChecked = false;
  bool isFifthChecked = false;

  void _checkAll(bool? value) {
    setState(() {
      isAllChecked = value ?? false;
      isFirstChecked = isAllChecked;
      isSecondChecked = isAllChecked;
      isThirdChecked = isAllChecked;
      isFourthChecked = isAllChecked;
      isFifthChecked = isAllChecked;
    });
  }

  void _checkIndividual(bool? value, int index) {
    setState(() {
      switch (index) {
        case 1:
          isFirstChecked = value ?? false;
          break;
        case 2:
          isSecondChecked = value ?? false;
          break;
        case 3:
          isThirdChecked = value ?? false;
          break;
        case 4:
          isFourthChecked = value ?? false;
          break;
        case 5:
          isFifthChecked = value ?? false;
          break;
      }
      isAllChecked = isFirstChecked &&
          isSecondChecked &&
          isThirdChecked &&
          isFourthChecked &&
          isFifthChecked;
    });
  }

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
              '서비스 이용을 위해\n 약관에 동의해주세요',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            CheckboxListTile(
              title: Text("전체 동의"),
              value: isAllChecked,
              onChanged: _checkAll,
            ),
            Divider(),
            CheckboxListTile(
              title: Text("코세틱 이용약관 동의 (필수)"),
              value: isFirstChecked,
              onChanged: (value) => _checkIndividual(value, 1),
            ),
            CheckboxListTile(
              title: Text("개인정보 수집 및 이용 동의 (필수)"),
              value: isSecondChecked,
              onChanged: (value) => _checkIndividual(value, 2),
            ),
            CheckboxListTile(
              title: Text("만 14세 이상입니다. (필수)"),
              value: isThirdChecked,
              onChanged: (value) => _checkIndividual(value, 3),
            ),
            CheckboxListTile(
              title: Text("마케팅 활용 및 광고 정보 수신 동의 (선택)"),
              value: isFourthChecked,
              onChanged: (value) => _checkIndividual(value, 4),
            ),
            CheckboxListTile(
              title: Text("개인정보 수집 및 이용 동의 (선택)"),
              value: isFifthChecked,
              onChanged: (value) => _checkIndividual(value, 5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    )
                ),
                onPressed: () {
                  if(isAllChecked || (isFirstChecked && isSecondChecked && isThirdChecked)){
                    context.push('/signup_input');
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("필수 약관에 동의해 주세요."))
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