import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/features/login/presentation/page/login_screen.dart';
import 'package:login/features/login/presentation/page/signup_input_screen.dart';
import 'package:login/firebase_options.dart';
import 'package:login/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthBloc authBloc = AuthBloc();
  final EmailBloc emailBloc = EmailBloc();

  runApp(MyApp(authBloc: authBloc, emailBloc: emailBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final EmailBloc emailBloc;

  MyApp({required this.authBloc, required this.emailBloc});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authBloc),
              BlocProvider.value(value: emailBloc),
            ],
            child: LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authBloc),
              BlocProvider.value(value: emailBloc),
            ],
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/signup_input',
          builder: (context, state) => BlocProvider.value(
            value: authBloc,
            child: SignupInputScreen(),
          ),
        ),
      ],
      redirect: (context, state) {
        final authState = authBloc.state;
        if (authState is AuthAuthenticated && state.uri.toString() == '/login') {
          return '/home';
        }
        return null;
      },
    );

    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
