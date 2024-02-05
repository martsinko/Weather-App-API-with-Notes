import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constrants/app_colors.dart';
import '../../models/note.dart';
class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.index,
    required this.filteredNotes,
    required this.screenHeight,
  });
 final int index;
  final List<Note> filteredNotes;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 4,
      overflow:  TextOverflow.ellipsis,
      text: TextSpan(
      text: '${filteredNotes[index].title}\n',
      style: GoogleFonts.montserrat(color: black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      height:  screenHeight / 600), 
      children: [
        TextSpan(
          text: '${filteredNotes[index].content}\n',
          style: GoogleFonts.montserrat(
            color:  black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: screenHeight / 600,
          )
        )
      ]
    ));
  }
}