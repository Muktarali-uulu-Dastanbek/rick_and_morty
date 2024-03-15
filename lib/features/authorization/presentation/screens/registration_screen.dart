// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/authorization/presentation/widget/email_input_widget.dart';
import 'package:rick_and_morty/internal/services/snack_bar_services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<RegistrationScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      // AlertDialog(
      //   title: Icon(
      //     Icons.warning,
      //     color: Colors.red,
      //   ),
      //   content: Text("Пароли должны совпадать"),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         navigator.pop();
      //       },
      //       icon: Text("OK"),
      //     )
      //   ],
      // );
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }

    navigator.pushNamedAndRemoveUntil(
        '/firebase', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Зарегистрироваться',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(30.r),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              EmailTextFromField(
                emailTextInputController: emailTextInputController,
              ),
              SizedBox(height: 30.h),
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
              const SizedBox(height: 30),
              TextFormField(
                maxLength: 16,
                cursorColor: Theme.of(context).colorScheme.primaryContainer,
                autocorrect: false,
                controller: passwordTextRepeatInputController,
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
                  hintText: 'Введите пароль еще раз',
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
              const SizedBox(height: 30),
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
                onPressed: signUp,
                child: Center(
                  child: Text(
                    'Регистрация',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
