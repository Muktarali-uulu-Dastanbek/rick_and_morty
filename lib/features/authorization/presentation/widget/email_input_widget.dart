import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailTextFromField extends StatelessWidget {
  const EmailTextFromField({
    super.key,
    required this.emailTextInputController,
  });

  final TextEditingController emailTextInputController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 40,
      cursorColor: Theme.of(context).colorScheme.primaryContainer,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      controller: emailTextInputController,
      validator: (email) => email != null && !EmailValidator.validate(email)
          ? 'Введите правильный Email'
          : null,
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
        hintText: 'Введите Email',
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
