import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/courses/courses_bloc.dart';
import 'presentation/blocs/units/units_cubit.dart';
import 'presentation/blocs/content/content_cubit.dart';
import 'presentation/blocs/exams/exams_bloc.dart';
import 'presentation/blocs/institutes/institutes_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependency injection
  await initializeDependencies();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const LearnSurveyingApp());
}

class LearnSurveyingApp extends StatelessWidget {
  const LearnSurveyingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<CoursesBloc>(
          create: (context) => sl<CoursesBloc>(),
        ),
        BlocProvider<UnitsCubit>(
          create: (context) => sl<UnitsCubit>(),
        ),
        BlocProvider<ContentCubit>(
          create: (context) => sl<ContentCubit>(),
        ),
        BlocProvider<ExamsBloc>(
          create: (context) => sl<ExamsBloc>(),
        ),
        BlocProvider<InstitutesBloc>(
          create: (context) => sl<InstitutesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Mesaha',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [
          Locale('ar', 'EG'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const SplashScreen(),
      ),
    );
  }
}
