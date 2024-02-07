import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/presentation/screens/account_screen.dart';
import 'package:rick_and_morty/features/presentation/screens/auth_screen.dart';
import 'package:rick_and_morty/features/presentation/screens/home_screen.dart';
import 'package:rick_and_morty/features/presentation/screens/registration_screen.dart';
import 'package:rick_and_morty/features/presentation/screens/reset_password_screen.dart';
import 'package:rick_and_morty/features/presentation/screens/verify_email_screen.dart';
import 'package:rick_and_morty/firebase_options.dart';
import 'package:rick_and_morty/internal/services/firebase_streem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,

            //накладывает страницу поверх другого,(без анимации)
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              },
            ),
          ),
          routes: {
            '/': (context) => const FirebaseStream(),
            '/home': (context) => const HomeScreen(),
            '/account': (context) => const AccountScreen(),
            '/login': (context) => const AuthorizationScreen(),
            '/signup': (context) => const RegistrationScreen(),
            '/reset_password': (context) => const ResetPasswordScreen(),
            '/verify_email': (context) => const VerifyEmailScreen(),
          },
          initialRoute: '/',
        );
      },
    );
  }
}
