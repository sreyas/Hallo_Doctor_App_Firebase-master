import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const greyTextColor = Color(0xFF8A8A8E);
  static const cardLighBluecolor = Color(0xFFECF9FC);
  static const secondaryBlueColor = Color(0xFF33C5FD);
  static const primaryBlueColor = Color(0xFF0091FC);
  static const whiteGreyColor = Color(0xFFF9F9F9);

  static final homeTitleStyle =
      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 20);

  static final homeSubTitleStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.w500, fontSize: 15, color: greyTextColor);

  static final appointmentDetailTextStyle =
      GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 18);

  static final appBarTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black);
  static final greyTextInfoStyle = GoogleFonts.nunito(
      fontWeight: FontWeight.w500, fontSize: 14, color: greyTextColor);
}
