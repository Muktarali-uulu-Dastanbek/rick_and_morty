// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/bottom_nav_bar.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    print(isEmailVerified);

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;

      await user.sendEmailVerification();
      log("${user}");

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));

      setState(() => canResendEmail = true);
    } catch (error) {
      final catchException = CatchException.convertException(error);

      print("ERROR EMAIL $error");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(catchException.message ?? 'Произошла ошибка'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const BottomNavBarScreen()
      : Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Верификация Email адреса',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            centerTitle: false,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Письмо с подтверждением было отправлено на вашу электронную почту, проверьте электронную почту. И откройте ссылку для подтверждения!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _launched = _launchGmail();
                      });
                    },
                    child: const Text(
                      'Открыть почту',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    icon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Повторно отправить',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      timer?.cancel();
                      await FirebaseAuth.instance.currentUser!.delete();
                    },
                    child: const Text(
                      'Отменить',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}

void _launchEmailApp() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'https',
    path: 'https://mail.google.com/mail/u/0/#inbox',
  );

  try {
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Не удалось открыть приложение почты.');
    }
  } catch (e) {
    print('Произошла ошибка при открытии приложения почты: $e');
  }
}

Future<void> _launchInBrowser(String? url) async {
  final Uri toLaunch = Uri(
    scheme: 'https',
    host: url ?? 'mail.google.com/mail',
  );
  if (!await launchUrl(
    toLaunch,
    mode: LaunchMode.inAppBrowserView,
  )) {
    throw Exception('Could not launch $url');
  }
}

Future<void> _launchGmail() async {
  const url = 'https://mail.google.com/';
  try {
    if (await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      // Успешно запущено
    } else {
      print('Не удалось открыть Gmail в браузере.');
    }
  } catch (e) {
    print('Произошла ошибка при открытии Gmail: $e');
  }
}
