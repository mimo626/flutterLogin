// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/features/login/presentation/bloc/signup/signup_bloc.dart';

import 'package:login/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // AuthBloc 인스턴스를 생성합니다.
    final authBloc = AuthBloc();
    final emailBloc = EmailBloc();
    final signupBloc = SignupBloc();

    // MyApp 위젯을 BlocProvider로 감싸고, AuthBloc을 제공하는 방식으로 변경합니다.
    await tester.pumpWidget(
      MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authBloc),
            BlocProvider.value(value: emailBloc),
            BlocProvider.value(value: signupBloc)
          ],
          child: MyApp(authBloc: authBloc, emailBloc: emailBloc, signupBloc: signupBloc,)
      )
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}