import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constrants/app_colors.dart';
import '../../../localization/locales.dart';
class TitleTextField extends StatelessWidget {
 TitleTextField({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      maxLines: null,
     style: GoogleFonts.montserrat(
      textStyle: TextStyle(
        wordSpacing: -1,
        fontSize: 28.5,
        color: white,
        fontWeight: FontWeight.w700
      )
     ),
      decoration:   InputDecoration(
        contentPadding: const  EdgeInsets.only(top: 0, left: 10 ),
        filled: false,
        hintText: LocaleData.tit.getString(context), 
        hintStyle: GoogleFonts.montserrat(
      textStyle: const   TextStyle(
        fontSize: 30,
        color: Colors.grey,
        fontWeight: FontWeight.w700
      )
     ),
        
        border: const  OutlineInputBorder(
          borderSide: BorderSide.none
        ) 
      ),
    );
  }
}