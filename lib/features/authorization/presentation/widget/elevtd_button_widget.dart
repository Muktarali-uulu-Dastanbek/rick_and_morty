import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
      onPressed: onPressed,
      child: Text(
        label,
        style: TextHelper.btnText,
      ),
    );
  }
}
