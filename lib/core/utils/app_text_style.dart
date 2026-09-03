import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/utils/app_color.dart';

class AppTextStyle {
  static TextStyle onBoardingScreenFrst = GoogleFonts.inter(
    fontSize: 36,
    color: AppColor.white,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
  static TextStyle onBoardingScreenFrstDescription = GoogleFonts.inter(
    fontSize: 20,
    color: Colors.white60,
    fontWeight: FontWeight.w400,
  );
  static TextStyle mainBtnTextStyle = GoogleFonts.inter(
    color: AppColor.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle onBoardingScreenTitle = GoogleFonts.inter(
    fontSize: 24,
    color: AppColor.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle onBoardingScreenDesc = GoogleFonts.inter(
    fontSize: 20,
    color: AppColor.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle appBarTxtStyle = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColor.yellow,
    fontWeight: FontWeight.w400,
  );
  static TextStyle normalTextStyle = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColor.white,
    fontWeight: FontWeight.w400,
  );
}
