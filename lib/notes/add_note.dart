import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/constrants/app_colors.dart';
import 'package:weather_app/constrants/app_dimensions.dart';
import '../localization/locales.dart';
import 'models/note.dart';
import 'widgets/add_note_widgets/content_text_field_widget.dart';
import 'widgets/add_note_widgets/save_float_act_button.dart';
import 'widgets/add_note_widgets/title_text_field_widget.dart';

class AddNote extends StatefulWidget {
 
  final Function() saveNotesToSharedPreferences;
  final Function() submitData;
  final Note? note;
  const AddNote({super.key, this.note, required this.submitData, required this.saveNotesToSharedPreferences});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
TextEditingController _titleController = TextEditingController();
TextEditingController _contentController = TextEditingController();



@override
  void initState() {
    if(widget.note != null){
       _titleController = TextEditingController(text: widget.note!.title);
    _contentController = TextEditingController(text: widget.note!.content);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: backgroundNotesColor,
      body: Column(
        children: [
             Padding(
              padding: EdgeInsets.only(top: screenHeight/25, left: screenWidth/ 60),
              child: Row(
                
                children: [
                  Wrap(
                    spacing: -6,
                    children: [
                  
                          IconButton(
                        
                icon: Icon(
                  size: 27.0,
                  Icons.arrow_back, color: white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
                         
                            
                           Padding(
                             padding:EdgeInsets.only(top: screenHeight /80.0),
                             child: Text(LocaleData.title.getString(context), style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 19,
                  color: white,
                  fontWeight: FontWeight.w600
                )
               ),),
                           ),
                    ]     
                  ), 
                ],
              )
            ),

             SizedBox( 
              width: 390,
              child: TitleTextField(titleController: _titleController),
            ),
          

            Padding(
             padding: EdgeInsets.only(top: screenHeight / topPaddingNote, left: screenWidth / leftPaddingNote, right:screenWidth / rightPaddingNote),
             child: ContentTextField(contentController: _contentController),
           )
        ],
      ),
      floatingActionButton: SaveFloatingActionButton(titleController: _titleController, contentController: _contentController, onSubmit: widget.submitData, saveNotes: widget.saveNotesToSharedPreferences ,),
    );
  }
}





