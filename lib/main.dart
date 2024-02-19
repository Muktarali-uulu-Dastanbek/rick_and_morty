import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/authorization/presentation/screens/auth_screen.dart';
import 'package:rick_and_morty/features/authorization/presentation/screens/registration_screen.dart';
import 'package:rick_and_morty/features/authorization/presentation/screens/verify_email_screen.dart';
import 'package:rick_and_morty/features/bottom_nav_bar.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_model.dart';
import 'package:rick_and_morty/features/characters/presentation/screens/character_info_screen.dart';
import 'package:rick_and_morty/features/locations/presentation/screens/location_info_screen.dart';
import 'package:rick_and_morty/features/settings/presentation/screens/account_screen.dart';
import 'package:rick_and_morty/features/settings/presentation/screens/reset_password_screen.dart';
import 'package:rick_and_morty/features/settings/presentation/screens/settings_screen.dart';
import 'package:rick_and_morty/features/splash_screen.dart';

import 'package:rick_and_morty/firebase_options.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/services/firebase_streem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();

  runApp(const MyApp());
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
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ButtonStyle(backgroundColor: Color(0xff)),
            // ),
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
            '/': (context) => const SplashScreen(),
            '/account_screen': (context) => const AccountScreen(),
            '/login': (context) => const AuthorizationScreen(),
            '/signup': (context) => const RegistrationScreen(),
            '/reset_password': (context) => const ResetPasswordScreen(),
            '/verify_email': (context) => const VerifyEmailScreen(),
            '/bottom_nav_bar': (context) => const BottomNavBarScreen(),
            '/firebase': (context) => const FirebaseStream(),
            '/settings': (context) => const SettingsScreen(),
            '/location_info': (context) => const LocationInfoScreen(),
            '/character_info': (context) => CharacterInfoScreen(
                  characterModel: ModalRoute.of(context)?.settings.arguments
                      as CharacterModel,
                ),
          },
          initialRoute: '/',
        );
      },
    );
  }
}
