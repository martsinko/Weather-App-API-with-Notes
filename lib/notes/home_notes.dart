import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constrants/app_colors.dart';
import 'package:weather_app/constrants/app_dimensions.dart';
import 'package:weather_app/notes/add_note.dart';
import 'package:weather_app/notes/models/note.dart';
import '../localization/locales.dart';
import 'widgets/home_notes_widgets/elevated_but_no_widget.dart';
import 'widgets/home_notes_widgets/elevated_but_yes_widget.dart';
import 'widgets/home_notes_widgets/notes_title.dart';
import 'widgets/home_notes_widgets/rich_text_widget.dart';


class NotesHome extends StatefulWidget { 
   const NotesHome({super.key});
    
  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {

  List<Note> filteredNotes = [];
   List<Note> allNotes = [];
  bool sorted = false;
  String title = "";
   String content = "";

  void saveNotesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList = filteredNotes.map((note) => note.toJson()).toList();
    await prefs.setStringList('note_list', jsonList);
  }

  void loadNotesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('note_list');

    if (data != null) {
      setState(() {
        allNotes = data.map((noteJson) => Note.fromJson(noteJson)).toList();
        onSearchTextChanged("");   
      });
    }
  }

void submitData() {
  if (title.trim().isNotEmpty && content.trim().isNotEmpty) {
    setState(() {
      Note newNote = Note(
        id: allNotes.length,
        title: title,
        content: content,
        modifiedTime: DateTime.now(),
      );
      allNotes.add(newNote);
      filteredNotes = List.from(allNotes);
    });
  }
  saveNotesToSharedPreferences();
}

  @override
void initState(){
super.initState();
loadNotesFromSharedPreferences();
}

List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }
    sorted = !sorted;
    return notes;
  }

getRandomColor(){
  Random random = Random();
  return backgroundColors[random.nextInt(backgroundColors.length)];
}

void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = allNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

 void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
     sampleNotes.remove(note);
      allNotes.remove(note);
      filteredNotes.removeAt(index);
      saveNotesToSharedPreferences();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundNotesColor ,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
          child:  Column(
          children: [
                Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back, color: white,)),
                  const NotesTitleText(),
                
                  IconButton(onPressed: (){
            setState(() {
              filteredNotes = sortNotesByModifiedTime(filteredNotes);
            });
                  }, icon: Icon(
                Icons.sort,
                color: white,
                 ))
                  ],),

                SizedBox(height: screenHeight / sizedBox1,),

              TextField(
      onChanged: (value){

        onSearchTextChanged(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: contentPadding),
        hintText: LocaleData.search.getString(context),
        hintStyle: GoogleFonts.montserrat(color: grey),
        prefixIcon: Icon(
          Icons.search,
          color: grey,
        ),
        fillColor: filled ,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: transparent)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: transparent)
        )
    
      ),
    ),

               SizedBox(height: screenHeight / sizedBox2,),

               Expanded(
                child: ListView.builder(
  itemCount: filteredNotes.length,
  itemBuilder: (BuildContext context, int index) {
    return Dismissible(
      direction:DismissDirection.endToStart,
      key: Key(filteredNotes[index].id.toString()),
      confirmDismiss: (DismissDirection direction) async {
        final result = await confirmDialog(context);
        return result ?? false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
                                deleteNote(index);
                          }  
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: white),
      ),

      child: Card(
        margin: EdgeInsets.only(bottom: screenHeight / 50),
        color: getRandomColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((BuildContext context) => AddNote(
                  note: filteredNotes[index], submitData: submitData, saveNotesToSharedPreferences: saveNotesToSharedPreferences,
                )),
              ),
            );
            if (result != null) {
              setState(() {
  int origIndex = allNotes.indexOf(filteredNotes[index]);
  filteredNotes = List.from(filteredNotes); 
  filteredNotes[origIndex] = Note(
    id: filteredNotes[origIndex].id,
    title: result[0],
    content: result[1],
    modifiedTime: DateTime.now(),
  );
});

            }
          },
          title: RichTextWidget(
            filteredNotes: filteredNotes,
            screenHeight: screenHeight,
            index: index,
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: screenHeight / richPadding),
            child: Text(
              'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedTime)}',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: filled,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  },
          )
               ),
          ],
                ),
        )
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          backgroundColor: filled,
          onPressed: () async{
          final result =  await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: ((BuildContext context) =>  AddNote(
                submitData: submitData, 
              saveNotesToSharedPreferences: saveNotesToSharedPreferences,))));
          if (result != null){
            setState(() {
              sampleNotes.add(
              Note(
              id: allNotes.length, 
              title: result[0], 
              content: result[1], 
              modifiedTime: DateTime.now())
            );
            filteredNotes = sampleNotes; 
            });
        
          }
          submitData();
          },
          child:  Icon(
            Icons.add,
            size: 38,
            color: white,
          ),
          ),
    );
  }

 Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title:  Text(
    LocaleData.confirmDialog.getString(context),
              style: const TextStyle(color: Colors.white),
            ),
            content:  const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   NoElevatedButton(),
                   YesElevatedButton(),
                ]),
          );
        });    
  }
}


 




   
    


