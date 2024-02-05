import 'package:flutter/material.dart';
import '../../../constrants/app_colors.dart';

class SaveFloatingActionButton extends StatelessWidget {
  const SaveFloatingActionButton({
    super.key,
    required TextEditingController titleController,
    required TextEditingController contentController, 
    required this.onSubmit, required this.saveNotes,
  }) : _titleController = titleController, _contentController = contentController;

final Function() saveNotes;
 final Function() onSubmit;
  final TextEditingController _titleController;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor: filled,
        onPressed: () {

          onSubmit();     
         saveNotes();
      Navigator.pop(context, [
      _titleController.text,
      _contentController.text
      ]
      );
        },
        child:  Icon(
          Icons.save,
          size: 38,
          color: white,
        ),
        );
  }
}