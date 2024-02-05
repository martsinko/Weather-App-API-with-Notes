import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/localization/locales.dart';

import '../../../constrants/app_colors.dart';

class NotesTitleText extends StatelessWidget {
  const NotesTitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(LocaleData.title.getString(context), style: GoogleFonts.montserrat(fontSize: 30, color: white, fontWeight: FontWeight.w500),);
  }
}