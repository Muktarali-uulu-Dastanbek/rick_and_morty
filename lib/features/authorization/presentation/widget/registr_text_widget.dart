import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';

class RegistrationTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;

  const RegistrationTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextHelper.w600s14,
        ),
        SizedBox(height: 10.h),
        TextFormField(
          cursorHeight: 14,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            filled: true,
            fillColor: const Color(0xffF2F2F2),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 13),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
         
            
          
        ),
      ],
    );
  }
}
