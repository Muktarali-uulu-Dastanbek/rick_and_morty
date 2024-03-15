import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/authorization/presentation/screens/verify_email_screen.dart';
import 'package:rick_and_morty/features/authorization/presentation/widget/email_input_widget.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );

      if (FirebaseAuth.instance.currentUser != null) {
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          navigator.push(MaterialPageRoute(
              builder: (context) => const VerifyEmailScreen()));
        } else {
          navigator.pushNamedAndRemoveUntil(
              '/bottom_nav_bar', (Route<dynamic> route) => false);
        }
      }
    } catch (error) {
      final catchException = CatchException.convertException(error);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(catchException.message ?? 'Произошла ошибка'),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.0.r),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 376.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/splash_screen/Rick_and_Morty.png",
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Логин",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8.h),
                  EmailTextFromField(
                    emailTextInputController: emailTextInputController,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Пароль",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    maxLength: 16,
                    cursorColor: Theme.of(context).colorScheme.primaryContainer,
                    autocorrect: false,
                    controller: passwordTextInputController,
                    obscureText: isHiddenPassword,
                    validator: (value) => value != null && value.length < 6
                        ? 'Минимум 6 символов'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.secondary,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 15.h,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      hintText: 'Введите пароль',
                      hintStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon: Icon(
                        Icons.password,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      suffix: InkWell(
                        onTap: togglePasswordView,
                        child: Icon(
                          isHiddenPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          319.w,
                          50.h,
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff22A2BD),
                      ),
                    ),
                    onPressed: login,
                    child: Center(
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "У вас еще нет аккаунта?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/signup'),
                        child: Text(
                          'Создать',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xff43D049),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
