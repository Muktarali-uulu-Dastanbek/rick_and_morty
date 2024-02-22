import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/internal/helpers/theme_helper.dart';

abstract class TextHelper {
  static TextStyle w600s12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: ThemeColor.colorText,
  );

  static TextStyle w600s14 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ThemeColor.colorText,
  );

  static TextStyle btnText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ThemeColor.colorBtnText,
  );

  static TextStyle w600s16 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: ThemeColor.colorText,
  );

  static TextStyle w600s34 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: ThemeColor.colorText,
  );

  static TextStyle hintText = TextStyle(
    fontSize: 14,
    color: ThemeColor.hintTextCl,
  );
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

  static TextStyle s24w600 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: ThemeColor.colorText,
  );

  static TextStyle s18w600 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: ThemeColor.colorText,
  );

  static TextStyle s14w500 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: ThemeColor.colorText,
  );

  static TextStyle s13w400 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ThemeColor.colorText,
  );

  static TextStyle s12w400 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ThemeColor.hintTextCl,
  );
}
