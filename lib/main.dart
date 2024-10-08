import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_state.dart';
import 'package:login/features/login/presentation/bloc/email_login/email_bloc.dart';
import 'package:login/features/login/presentation/bloc/google_login/auth_bloc.dart';
import 'package:login/features/login/presentation/page/login_screen.dart';
import 'package:login/features/signup/data/repositories/user_repository_impl.dart';
import 'package:login/features/signup/domain/usecases/user_usecase.dart';
import 'package:login/features/signup/presentation/bloc/signup/signup_bloc.dart';
import 'package:login/features/signup/presentation/page/signup_input_screen.dart';
import 'package:login/features/login/presentation/page/terms_conditions_screen.dart';
import 'package:login/features/onboarding/presentation/page/onboarding1_screen.dart';
import 'package:login/firebase_options.dart';
import 'package:login/home_screen.dart';
import 'package:login/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthBloc authBloc = AuthBloc();
  final EmailBloc emailBloc = EmailBloc();

  // UserRepositoryImpl 인스턴스 생성
  final UserRepositoryImpl userRepository = UserRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance);

  // UserUsecase 인스턴스 생성
  final UserUsecase userUsecase = UserUsecase(userRepository);

  // SignupBloc 인스턴스 생성
  final SignupBloc signupBloc = SignupBloc(userUsecase: userUsecase);

  final prefs = await SharedPreferences.getInstance();
  final bool isOnboardingCompleted = prefs.getBool('isOnboardingCompleted') ?? false;

  runApp(MyApp(initialRoute: isOnboardingCompleted ? '/login' : '/onboarding',
      authBloc: authBloc, emailBloc: emailBloc, signupBloc: signupBloc));
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc;
  final EmailBloc emailBloc;
  final SignupBloc signupBloc;
  final String initialRoute;


  MyApp({required this.authBloc, required this.emailBloc, required this.signupBloc, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authBloc),
              BlocProvider.value(value: emailBloc),
              BlocProvider.value(value: signupBloc),
            ],
            child: LoginScreen(),
          ),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => BlocProvider.value(
            value: signupBloc,
            child: Onboarding1Screen(),
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
          path: '/terms',
          builder: (context, state) => BlocProvider.value(
            value: signupBloc,
            child: TermsConditionsScreen(),
          ),
        ),
        GoRoute(
          path: '/signup_input',
          builder: (context, state) => BlocProvider.value(
            value: signupBloc,
            child: SignupInputScreen(),
          ),
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authBloc),
              BlocProvider.value(value: emailBloc),
            ],
            child: MainScreen(),
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
