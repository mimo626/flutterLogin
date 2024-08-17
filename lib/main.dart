import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';
import 'package:login/features/login/presentation/page/login_screen.dart';
import 'package:login/firebase_options.dart';

import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final AuthBloc authBloc = AuthBloc();
  runApp(MyApp(authBloc: authBloc,));
}
class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  MyApp({required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider.value(
            value: authBloc,
            child: LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => BlocProvider.value(
            value: authBloc,
            child: HomeScreen(),
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