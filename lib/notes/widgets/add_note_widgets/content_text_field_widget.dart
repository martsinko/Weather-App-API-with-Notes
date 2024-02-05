import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constrants/app_colors.dart';
import '../../../localization/locales.dart';
class ContentTextField extends StatelessWidget {
 ContentTextField({
    super.key,
    required TextEditingController contentController,
  }) : _contentController = contentController;

  final TextEditingController _contentController;
 

  @override
  Widget build(BuildContext context) {
    return TextField(
     
     controller: _contentController,
     style: GoogleFonts.montserrat(
       textStyle:TextStyle(
        fontSize: 16,
        color: white,
        fontWeight: FontWeight.w500
       )
     ),
       maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration:  InputDecoration(
                hintText: LocaleData.body.getString(context),
                hintStyle: GoogleFonts.montserrat(textStyle: const TextStyle(color: Colors.grey, fontSize: 19, fontWeight: FontWeight.w700)),
     contentPadding: const  EdgeInsets.only(left: 13, top: 0.0),
     border: const OutlineInputBorder(
       borderSide: BorderSide.none,
     ),
     
       ),
           );
  }
}