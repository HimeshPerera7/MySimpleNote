import 'package:flutter/material.dart';
import 'package:mysimplenote/db_helper/sql_helper.dart';
import 'package:mysimplenote/models/note_model.dart';

class NoteEdit extends StatelessWidget {
  const NoteEdit({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: note.title);
    final TextEditingController bodyController =
        TextEditingController(text: note.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.cyanAccent,
        shadowColor: Colors.cyanAccent,
        elevation: 5,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              style: const TextStyle(
                fontSize: 24,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
              ),
            ),

            const SizedBox(height: 10),
            
            TextFormField(
              controller: bodyController,
              style: const TextStyle(
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: "Your Note",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      
      floatingActionButton: GestureDetector(
        onTap: () async {
          if (titleController.text.isEmpty || bodyController.text.isEmpty) {
            return;
          }
          final updatedNote = Note(
            id: note.id,
            title: titleController.text,
            description: bodyController.text,
          );

          await DatabaseHelper.instance.updateNote(updatedNote);

           Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), 
            color: Colors.cyanAccent,
          ),
          width: 100,
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.save,
                color: Colors.black,
                size: 35,
              ),

              const SizedBox(width: 5),

              const Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
